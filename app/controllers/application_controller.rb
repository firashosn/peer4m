class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def after_sign_in_path_for(user)
    if user.role == "instructor" || user.role == "student"
    	courses_path
	elsif user.role == "administrator"
    	admin_index_path
    end
  end


end
