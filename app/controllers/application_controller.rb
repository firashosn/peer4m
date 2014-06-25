class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def after_sign_in_path_for
    
    if @user.role = "instructor"
    new_courses_path
    
    elsif @user.role = "student"
    course_path
    
    end
  end

end
