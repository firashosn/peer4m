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
    # binding.pry
    @team = assignments.teams.build(team_params)
      if @team.save
        redirect_to course_assignment_teams_path(@course)
    else
      render 'new'
    end
 end


  def index
    @course = Course.find(params[:course_id])
   @assignment = Assignment.find(params[:assignment_id])
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
      params.require(:team).permit(:name)
    end



end

