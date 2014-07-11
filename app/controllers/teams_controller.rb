class TeamsController < ApplicationController

  before_action :authenticate_user!, except: [:show]
  #before_action :set_team, only: [:edit, :update, :destroy]

  def new

    @team = Team.new
    @course = Course.find(params[:course_id])
    curUsers = User.joins(:enrollments).where('enrollments.course_id' => @course[:id]) 
    curStudents = curUsers.where('role' => 'student')
    @students = []

    if Team.nil?
    else
      existing_teams = Team.where('assignment_id' => params[:assignment_id])
      existing_team_ids = existing_teams.pluck('id')
      if existing_team_ids.count > 0
        curStudents.each do |student|
          current_student_teams = student.team_enrollments.pluck('team_id')
          is_match = existing_team_ids & current_student_teams
          if is_match.empty?
           @students.push(student) 
          end
        end
      else
        @students = curStudents
      end
    end
    
  end

  def create
    @assignment = Assignment.find(params[:assignment_id])
    @team = @assignment.teams.build()
    

    if @team.save
      #binding.pry
      params[:status].each do |k,v|
        addUserToTeam(v,@team)
      end
        redirect_to course_assignment_teams_path
    else
        render 'new'   
    end
      
 end

def addUserToTeam(userId,team)
  if(userId != nil)
          team.team_enrollments.create(:team_id => @team.id, :user_id => userId)
  end
end


  def index
   # binding.pry
   @course = Course.find(params[:course_id]) 
   @assignment = Assignment.find(params[:assignment_id])
   #@teams = Team.joins(:team_enrollments).where('team_enrollments.assignment_id' => @assignment.id)
   if current_user.role == "student"
    #binding.pry
   #get students asociated with this team
   assignment_teams = Team.where(:assignment_id => @assignment.id)
   @my_team = nil
   assignment_teams.each do |team| 
    @my_team = current_user.team_enrollments.find_by(:team_id => team.id)
    @team_id = team.id
    break if @my_team != nil
   end

    if @my_team != nil
      @teammates = User.joins(:team_enrollments).where('team_enrollments.team_id' => @my_team.team_id)
      @teammates = @teammates.where.not(:id => current_user.id)
    end
   else
    @teams = Team.where(:assignment_id => @assignment.id)
   end
 end

 
 def show
  @assignment = Assignment.find(params[:id])
end

def edit
    @course = Course.find(params[:course_id])
end

def update
  # binding.pry
    @course = Course.find(params[:course_id])
    @assignment = Assignment.find(params[:id])
    if @assignment.update(assignment_params)
      redirect_to course_assignments_path(@course)

    else
    render 'edit'
    end
  end

def destroy
  #binding.pry
    @assignment = Assignment.find(params[:assignment_id])
    @team = Team.find(params[:id])
    @team_enrollment = TeamEnrollment.where(:team_id => params[:id])
    binding.pry
    @team_enrollment.destroy_all
    @team.destroy
    redirect_to course_assignment_teams_path(params[:course_id], params[:assignment_id])
  end

 private
    def team_params
      #params.require(:team).permit()
    end

  #def set_team
      #@team = Team.find(params[:id])
    #end



end

