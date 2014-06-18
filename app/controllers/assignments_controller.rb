class AssignmentsController < ApplicationController
def new
	end

def create
    @course = Course.find(params[:course_id])
    @assignment = @course.assignments.create(assignment_params)
    if @assignment.save
    	redirect_to course_assignment_path(@course,@assignment)
    else
    	render 'new'
    end
 end
 
 def show
	  @assignment = Assignment.find(params[:id])
end

 private
    def assignment_params
      params.require(:assignment).permit(:name, :open_time, :close_time, :instructions)
    end

end
