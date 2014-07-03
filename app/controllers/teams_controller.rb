class TeamsController < ApplicationController

  before_action :authenticate_user!, except: [:show]

  def new
    @team = Team.new
  end


  def index
    @course = Course.find(params[:course_id])
    @assignment = Assignment.find(params[:id])
    @teams = @course.assignment.team
 end



end
