class EvaluationsController < ApplicationController

def new
  @evaluation = Evaluation.new
  @student = User.find_by(:id => params[:format]) 
  #binding.pry
end

def index
  #binding.pry
  #@evaluations = Evaluation.find(:id => params[:team_id])

end

 def show
  #binding.pry
  @reviewer = current_user
  @student = User.find_by(:id => params[:id])
  @team = Team.find_by(:id => params[:team_id])
    #binding.pry
  #reviewee
  #team
  #create evaluation
end

  def create
 
  	@team = Team.find_by(:id => params[:team_id])
    @course = Course.find_by(:id => params[:course_id])
    @assignment = Assignment.find_by(:id => params[:assignment_id])
    @evaluation = @team.evaluations.build(evaluation_params)
    if(@evaluation.save)
      redirect_to course_assignment_teams_path(@course,@assignment,@team)
    end
 end

   private
    def evaluation_params
      params.require(:evaluation).permit(:reviewer_id, :reviewee_id, :quality_of_work, :dependability, :communication, :team_player_skills, :work_ethic, :comment)
    end

end
