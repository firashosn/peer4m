class AdminController < ApplicationController

  before_action :authenticate_user!, except: [:show]

  def create  
  	redirect_to admin_index_path(@users)
  end

  def show
  	# binding.pry
  end

  def index
    @users = nil
    user_role = params['role'] == "" ? '*' :  params['role']
    user_institution = params['institution'] == "" ? '*' :  params['institution']
    user_program = params['program'] == "" ? '*' :  params['program']
      @users = User.all
        
    #@users = User.where(:role => user_role, :current_institution => user_institution, :current_program => user_program)
  end

  def edit
    #binding.pry
  end

  def update
    # binding.pry
  end

  def destroy
    user_id = params['id']
    user = User.find_by(:id => user_id)
    enrollments = Enrollment.where(:user_id => user_id)
    enrollments.destroy_all
    team_enrollments = TeamEnrollment.where(:user_id => user_id)
    team_enrollments.destroy_all
    user.destroy
    redirect_to admin_index_path, flash: { success: "Successfully deleted!" }
  end


end
