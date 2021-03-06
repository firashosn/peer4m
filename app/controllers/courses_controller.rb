class CoursesController < ApplicationController

  before_action :authenticate_user!, except: [:show]
  before_action :set_course, only: [:edit, :update, :destroy]

  def new
    @course = Course.new
    set_start_date
  end

  def create
      @user = User.find(current_user.id)
      if current_user.role == "instructor"
        @course = current_user.courses.build(course_params)
        @course.enrollment_password = Devise.friendly_token
        @currUser = current_user
        @user = User.find(@currUser.id)
        if @course.save
          @user.enrollments.create(:course_id => @course.id, :user_id => @user.id)
        	redirect_to courses_path, flash: { success: "You have successfully created a course!" }
        else
        	render 'new'
        end
      elsif current_user.role == "student"
        params_c = params[:course]
        c = Course.find_by(enrollment_password: params_c[:enrollment_password])
        if c != nil && !c.is_user_already_enrolled(current_user)
          @user.enrollments.create(:course_id => c.id, :user_id => current_user.id)
          redirect_to courses_path
        else
          redirect_to courses_path, flash: { error: "You have already enrolled in this course!" }
        end
      end
  end
   
  def show
  	  @course = Course.find(params[:id])
  end

  def index
    
    #enrollments = Enrollment.where(user_id: current_user.id)
    @courses = Course.joins(:enrollments).where('enrollments.user_id' => current_user.id)
    #@courses = current_user.courses
  end

  def edit
    set_start_date
  end

  def update
    if @course.update(course_params)
      redirect_to courses_path, flash: { success: "Successfully updated the course!" }
    else
      render 'edit'
    end
  end

  def destroy
    @enrollments = Enrollment.where(:course_id => @course.id)
    @enrollments.destroy_all
    @course.destroy
    redirect_to courses_path, flash: { success: "Successfully deleted!" }
  end

  private
    def course_params
      params.require(:course).permit(:course_id, :course_name, :start_date)
    end

    def set_course
      @course = Course.find(params[:id])
    end

    def set_start_date
      @course.start_date = Date.today unless @course.start_date
    end

end
