class StudentsController < ApplicationController

def new
	end

	 def create
	 	@student = Student.new(student_params)

	 	if @student.save
	 		redirect_to @student
	 	else
	 		render 'new'
	 	end
	 end

	def show
	  @student = Student.find(params[:id])
	end

private
	def instructor_params
		params.require(:student).permit(:user_name, :password)
	end

end
