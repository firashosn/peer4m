class AssignmentsController < ApplicationController

    before_action :authenticate_user!, except: [:show]
  before_action :set_assignment, only: [:edit, :update, :destroy]


def new
    @assignment = Assignment.new
    set_close_time
end

def index
    @course = Course.find(params[:course_id])
    @assignments = @course.assignments
 end

def create
    @course = Course.find(params[:course_id])
    #binding.pry
    @assignment = @course.assignments.build(assignment_params)
    
      if @assignment.save
        redirect_to course_assignments_path(@course)
    else
    	render 'new'
    end
 end

 
 def show
	@assignment = Assignment.find(params[:id])
end

def edit
    set_close_time
    @course = Course.find(params[:course_id])
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
      params.require(:assignment).permit(:name, :close_time)
    end

    def set_assignment
      @assignment = Assignment.find(params[:id])
    end

    def set_close_time
      @assignment.close_time = Date.today unless @assignment.close_time
    end

end
