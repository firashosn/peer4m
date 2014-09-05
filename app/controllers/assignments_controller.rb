class AssignmentsController < ApplicationController

  before_action :authenticate_user!, except: [:show]
  before_action :set_assignment, only: [:edit, :update, :destroy]


def new
    @assignment = Assignment.new
    set_open_date
end

def index
    @course = Course.find(params[:course_id])
    @assignments = @course.assignments
 end

def create
    @course = Course.find(params[:course_id])
    @assignment = @course.assignments.build(assignment_params)
    
    if is_valid_params(params[:assignment]) && @assignment.save
      redirect_to course_assignments_path(@course), flash: { success: "Successfully created an assignment!" }
    else
    	redirect_to course_assignments_path(@course), flash: { error: "Please specify a closing time" }
    end
 end

 
def show
	@assignment = Assignment.find(params[:id])
end

def edit
    @course = Course.find(params[:course_id])
    set_open_date
    # format_close_date
end

def update
    @course = Course.find(params[:course_id])
    @assignment = Assignment.find(params[:id])
    if @assignment.update(assignment_params)
      redirect_to course_assignments_path(@course), flash: { success: "Successfully updated the assignment!" }

    else
    render 'edit'
    end
  end

def destroy
    @course = Course.find(params[:course_id])
    @assignment.destroy
    redirect_to course_assignments_path(@course), flash: { success: "Successfully deleted!" }
end

 private
    def assignment_params
      params.require(:assignment).permit(:name, :open_time, :close_time)
    end

    def set_assignment
      @assignment = Assignment.find(params[:id])
    end


    def is_valid_params(params)
        if params[:close_time] == ""
          return false
        end
      return true
    end

    def set_open_date
      @assignment.open_time = Date.today unless @assignment.open_time
    end

    # def format_close_date
    #   @assignment.close_time = Date.strftime("%d/%m/%Y")
    # end

    # def set_close_time
    #   @assignment.close_time = Date.today unless @assignment.close_time
    # end

end
