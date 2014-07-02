class RegistrationsController < Devise::RegistrationsController

before_action :authenticate_user!

  def create
    @user = User.new(user_params)
    if @user.save
    	if @user.role == "instructor"
    		redirect_to courses_path
      elsif @user.role == "student"
        #courses_path(:user_id)
    	end
    else 
      redirect_to :back, :flash => { :error => "You fucked up bitch! Try Again" } 

    	# 	  user_courses_path(:user_id)
    	# end
    end
  end

private
  def user_params
    params.require(:user).permit(:email, :password, :role)
  end

end 
