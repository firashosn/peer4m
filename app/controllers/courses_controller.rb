class CoursesController < ApplicationController
def index
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

  private
    def course_params
      params.require(:course).permit(:course_id, :course_name)
    end

end
