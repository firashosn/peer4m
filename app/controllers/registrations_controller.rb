class RegistrationsController < Devise::RegistrationsController

before_action :authenticate_user!

  def create
    @user = User.new(user_params)
    if @user.save
    	if @user.role == "instructor" || "student"
    		redirect_to courses_path
    	end
    else 

      redirect_to :back

    end
  end

private

  def user_params
    # binding.pry
    params.require(:user).permit(:email, :password, :password_confirmation, :role, :first_name, :last_name)
  end

end 
