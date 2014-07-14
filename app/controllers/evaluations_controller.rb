class EvaluationsController < ApplicationController

def new
  @evaluation = Evaluation.new
  @student = User.find_by(:id => params[:format]) 
  #binding.pry
end

def index
  binding.pry
  #@evaluations = Evaluation.find(:id => params[:team_id])

end

 def show
  binding.pry
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
    @evaluation.reviewer_id = current_user.id
    binding.pry
    #@evaluation = @team.evaluations.create(:reviewer_id => current_user.id, :reviewee_id => '19', :quality_of_work => params[:quality_of_work], :dependability => params[:dependability], :communication => params[:communication], :team_player_skills => params[:team_player_skills], :work_ethic => params[:work_ethic], :comment => params[:comment])
    if(@evaluation.save)
      redirect_to course_assignment_teams_path(@course,@assignment,@team)
    end
  	#@team.evaluations.build(evaluation_params)
 end

   private
    def evaluation_params
      params.require(:evaluation).permit(:reviewee_id, :quality_of_work, :dependability, :communication, :team_player_skills, :work_ethic, :comment)
    end

end
