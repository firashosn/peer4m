class AssignmentsController < ApplicationController

def new
    @assignment = Assignment.new
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

 def index
    @assignments = Assignment.all
 end
 
 def show
	  @assignment = Assignment.find(params[:id])
end

def edit
    @assignment = Assignment.find(params[:id])
  end

def update
    @assignment = Assignment.find(params[:id])
    if @assignment.update(assignment_params)
      redirect_to course_assignment_path(@course,@assignment)
    else
    render 'edit'
    end
  end

 private
    def assignment_params
      params.require(:assignment).permit(:name, :open_time, :close_time, :instructions)
    end

end
