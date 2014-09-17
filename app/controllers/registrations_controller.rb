class RegistrationsController < Devise::RegistrationsController

before_action :authenticate_user!

before_filter :set_cache_buster

  def set_cache_buster
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # Tell the UserMailer to send a welcome email after save
        UserMailer.welcome_email(@user).deliver
        #if @user.role == "student" 
          @user.notifications.create(:link_to_id => nil, :user_id => @user.id, :notification_type => Notification.types['welcome'])
        #end
      if @user.role == "instructor" || "student"
    		redirect_to courses_path
      elsif @user.role == "administrator"
        respond_to do |format|
           format.js {render inline: "location.reload();" }
        end
    	end
    else 

      clean_up_passwords @user
      @validatable = devise_mapping.validatable?
      if @validatable
        @minimum_password_length = resource_class.password_length.min
      end
      respond_with @user
    end
  end

private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :role, :first_name, :last_name, :current_program, :current_institution)
  end

end 
