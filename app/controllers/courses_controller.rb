class CoursesController < ApplicationController


  def new
    @course = Course.new
  end

  def create
      @instructor = Instructor.find(params[:instructor_id])
      @course = @instructor.courses.create(course_params)
      if @course.save
      	redirect_to instructor_course_path(@instructor,@course)
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
