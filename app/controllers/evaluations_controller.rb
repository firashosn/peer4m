class EvaluationsController < ApplicationController

def new
	binding.pry
  @evaluation = Evaluation.new 
end

 def show
  @reviewer = current_user
  @student = User.find_by(:id => params[:id])
  @team = Team.find_by(:id => params[:team_id])
    #binding.pry
  #reviewee
  #team
  #create evaluation
end

  def create
  	#@team = Team.find_by(:id => params[:team_id])
  	#@team.evaluations.build(evaluation_params)
    #binding.pry  
 end

   private
    def evaluation_params
      params.require(:evaluation).permit(:quality_of_work, :dependability, :communication, :team_player_skills, :work_ethic, :comment)
    end

end
