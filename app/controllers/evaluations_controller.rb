class EvaluationsController < ApplicationController

def new
  @evaluation = Evaluation.new 
end



   private
    def evaluation_params
      params.require(:evaluation).permit(:quality_of_work, :dependability, :communication, :team_player_skills, :work_ethic, :comment)
    end

end
