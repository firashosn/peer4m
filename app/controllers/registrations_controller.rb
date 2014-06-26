class RegistrationsController < Devise::RegistrationsController

before_action :authenticate_user!

  def create
    @user = User.new(user_params)
    if @user.save
    	if @user.role == "instructor"
    		  redirect_to new_session_path(@user)
      elsif @user.role == "student"
        redirect_to new_session_path(@user)
    	end
    end
  end

private
  def user_params
    params.require(:user).permit(:email, :password, :role)
  end

end 
