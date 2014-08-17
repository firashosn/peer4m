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
    
    if @students != nil && @students.count > 1
      #@students = @students.order(last_name: :asc)
    end

  end

  def create
    use_previous = params[:use_previous]

    if use_previous == nil
      @assignment = Assignment.find(params[:assignment_id])
      @team = @assignment.teams.build()
      @team.name = @team.get_team_index(params[:assignment_id])

      if @team.save
        #binding.pry
        params[:status].each do |k,v|
          addUserToTeam(v,@team)
        end
          redirect_to course_assignment_teams_path
      else
          render 'new'   
      end
    else
      binding.pry
    end
    
 end

def addUserToTeam(userId,team)
  if(userId != nil)
          team.team_enrollments.create(:team_id => @team.id, :user_id => userId)
          team_user = User.find_by(:id => userId)
          team_user.notifications.create(:link_to_id => @team.id, :user_id => team_user.id, :notification_type => Notification.types['team_created'])
          binding.pry
  end
end


  def index
   @view_students = false
   @has_teammates = true
   @course = Course.find(params[:course_id]) 
   @assignment = Assignment.find(params[:assignment_id])
   if current_user.role == "student"
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
    else
      @has_teammates = false
    end
   else #if current_user.role == "student"
    if params[:format].nil? 
    else
      @view_students = true
      @teammates = User.joins(:team_enrollments).where('team_enrollments.team_id' => params[:format])
      @team_id = params[:format]
    end

      @teams = Team.where(:assignment_id => @assignment.id)
      @teams = @teams.order(name: :asc)

   end #else #if current_user.role == "student"
   # binding.pry
 end

 
 def show
  @assignment = Assignment.find(params[:id])
end

def edit
    @course = Course.find(params[:course_id])
    @team = Team.find(params[:id])

    curUsers = User.joins(:enrollments).where('enrollments.course_id' => @course.id) 
    curStudents = curUsers.where('role' => 'student')

    #students on this team
    @students = User.joins(:team_enrollments).where('team_enrollments.team_id' => @team.id) 
    #need the students that are not on a team in this assignment

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

def update
    @course = Course.find(params[:course_id])
    @assignment = Assignment.find(params[:assignment_id])
    @team = Team.find(params[:id])

    @team_users = TeamEnrollment.where(:team_id => @team.id)
    @team_users.destroy_all

    if @team.save
      params[:status].each do |k,v|
      addUserToTeam(v,@team)
      end
      redirect_to course_assignment_teams_path(params[:course_id], params[:assignment_id])
    else
      render 'edit'
    end
  end

def destroy
    @assignment = Assignment.find(params[:assignment_id])
    @team = Team.find(params[:id])
    @team_enrollment = TeamEnrollment.where(:team_id => params[:id])
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

