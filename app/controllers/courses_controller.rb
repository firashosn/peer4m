class CoursesController < ApplicationController


  def new
    @course = Course.new
  end

  def create
     #binding.pry
      @currUser = current_user
      @user = User.find(@currUser.id)
      @course = Course.create(course_params)

      if @course.save
        @user.enrollments.create(:course_id => @course.id, :user_id => @user.id)
      	redirect_to user_course_path(@user,@course)
      else
      	render 'new'
      end
    end
   
   def show
  	  @course = Course.find(params[:id])
  	end

  def index
    @courses = Course.all
  end

  def edit
    @course = Course.find(params[:id])
  end

  def update
    @course = Course.find(params[:id])
    if @course.update(course_params)
      redirect_to courses_path
    else
    render 'edit'
    end
  end


  private
    def course_params
      params.require(:course).permit(:course_id, :course_name)
    end

end
