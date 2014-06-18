class InstructorsController < ApplicationController
	def new
	end

	 def create
	 	@instructor = Instructor.new(instructor_params)

	 	if @instructor.save
	 		redirect_to @instructor
	 	else
	 		render 'new'
	 	end
	 end

	def show
	  @instructor = Instructor.find(params[:id])
	end

private
	def instructor_params
		params.require(:instructor).permit(:user_name, :password)
	end

end

