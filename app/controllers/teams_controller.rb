class TeamsController < ApplicationController

  before_action :authenticate_user!, except: [:show]

  def new
    @team = Team.new
    @course = Course.find(params[:course_id])
    curUsers = User.joins(:enrollments).where('enrollments.course_id' => @course[:id]) 
    curStudents = curUsers.where('role' => 'student')
    @students = curStudents
   # binding.pry
   #if Team != nil
    # existimgTeams = Team.find(params[:assignment_id])
   #end

    #studentsInTeams = existimgTeams
    #go through for each team and make sure the students are removed form our list of students
#do a check to see if students belong to a team 
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
  binding.pry
  if(userId != nil)
          team.team_enrollments.create(:team_id => @team.id, :user_id => current_user.id)
  end
end


  def index
    #binding.pry
   @course = Course.find(params[:course_id]) 
   @assignment = Assignment.find(params[:assignment_id])
   #@teams = Team.joins(:team_enrollments).where('team_enrollments.assignment_id' => @assignment.id)
   @teams = Team.where(:assignment_id => @assignment.id)
 end

 
 def show
  @assignment = Assignment.find(params[:id])
end

def edit
    set_close_time
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
    @course = Course.find(params[:course_id])
    @assignment.destroy
    redirect_to course_assignments_path(@course)
  end

 private
    def team_params
      #params.require(:team).permit()
    end



end
