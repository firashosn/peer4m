class AssignmentsController < ApplicationController


def new
    @assignment = Assignment.new
end

def index
    @course = Course.find(params[:course_id])
    @assignments = @course.assignments
 end

def create
    @course = Course.find(params[:course_id])
    @assignment = course.assignments.build
      if @assignment.save
        redirect_to course_assignments_path(course)
    else
    	render 'new'
    end
 end

 
 def show
	  @assignment = Assignment.find(params[:id])
end

def edit
    # @assignment = Assignment.find(params[:id])
  end

def update
    @assignment = Assignment.find(params[:id])
    if @assignment.update(assignment_params)
      redirect_to course_assignments_path(course)
    else
    render 'edit'
    end
  end

def destroy
    @assignment.destroy
    redirect_to course_assignments_path(course)
  end

 private
    def assignment_params
      params.require(:assignment).permit(:name, :open_time, :close_time, :instructions)
    end

end
