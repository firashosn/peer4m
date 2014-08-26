class EvaluationsController < ApplicationController

def new
  @evaluation = Evaluation.new
  @student = User.find(params[:user_id])
  #binding.pry
end

  def index
  end

  def show
    @reviewer = current_user
    @student = User.find_by(:id => params[:id])
    @team = Team.find_by(:id => params[:team_id])
  end

  def create
  	@team = Team.find_by(:id => params[:team_id])
    @course = Course.find_by(:id => params[:course_id])
    @assignment = Assignment.find_by(:id => params[:assignment_id])
    @evaluation = @team.evaluations.build(evaluation_params)
    if(is_valid_params(params[:evaluation]) && @evaluation.save)
      reviewee = User.find_by(:id => params[:evaluation][:reviewee_id])
      reviewee.notifications.create(:link_to_id => nil, :user_id => params[:reviewee_id], :notification_type => Notification.types['evaluated'])
      redirect_to course_assignment_teams_path(@course,@assignment,@team)
    else
      redirect_to course_assignment_teams_path(@course,@assignment,@team)
    end
 end

   private
    def evaluation_params
      params.require(:evaluation).permit(:reviewer_id, :reviewee_id, :quality_of_work, :dependability, :communication, :team_player_skills, :work_ethic, :comment)
    end

    def is_valid_params(params)
      User::EVALUATION_FIELDS.each do |eval|
        if params[eval] == ''
          return false
        end
      end
      return true
    end

end
