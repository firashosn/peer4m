class UsersController < ApplicationController

  before_action :authenticate_user!

   roles = ["instructor", "student"]

  def create
    @user = User.new(params[:user])
    if @user.save
      if @user.intructor?
        redirect_to courses_path
      elsif @user.student?
        redirect_to show_course_path(@course)
    end
  end

end





end
