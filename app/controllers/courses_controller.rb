class CoursesController < ApplicationController

  before_action :authenticate_user!, except: [:show]
  before_action :set_course, only: [:edit, :update, :destroy]

  def new
    @course = Course.new
    set_start_date
  end

  def create
      @course = current_user.courses.build(course_params)
      @course.enrollment_password = Devise.friendly_token
      binding.pry
      if @course.save
      	redirect_to courses_path

     #binding.pry
      # @currUser = current_user
      # @user = User.find(@currUser.id)
      # @course = Course.create(course_params)

      # if @course.save
      #   @user.enrollments.create(:course_id => @course.id, :user_id => @user.id)
      # 	redirect_to user_course_path(@user,@course)

      #@course = Course.new(course_params)
      #if @course.save
      #	redirect_to user_courses_path(:id)

      else
      	render 'new'
      end
  end
   
  def show
  	  @course = Course.find(params[:id])
  end

  def index
    @courses = current_user.courses
  end

  def edit
    set_start_date
  end

  def update
    if @course.update(course_params)
      redirect_to courses_path
    else
      render 'edit'
    end
  end

  def destroy
    @course.destroy
    redirect_to courses_path
  end

  def csv_import_studentlist
     @parsed_file=CSV::Reader.parse(params[:student_list][:file])
     n=0
     @parsed_file.each  do |row|
       student=Uset.new
       student.email=row[1]
       if c.save
          n=n+1
       else
          binding.pry
       end
     end
     flash.now[:message]="CSV Import Successful,  #{n} new records added to data base"
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
