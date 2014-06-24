class UsersController < ApplicationController

  before_action :authenticate_user!

   roles = ["instructor", "student"]

  def create
    binding.pry
    @user = User.new(user_params)
    @user.update(role: 2)
    if @user.save
     # if @user.intructor?
      #  redirect_to courses_path
      #elsif @user.student?
       # redirect_to show_course_path(@course)
    end
  end

end

private
  def user_params
    params.require(:user).permit(:email, :password, :role)
  end



end
