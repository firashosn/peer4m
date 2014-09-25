class AdminController < ApplicationController

  before_action :authenticate_user! 
  before_filter do 
    redirect_to courses_path unless current_user && current_user.role == 'administrator'
  end

  def new  
    
  end

  def create  
    @user = User.new
    #if @user.save
  	 redirect_to admin_index_path(@users)
    #else
      #redirect_to admin_index_path(@users), flash: { error: "Could not creat user" }
    #end
  end

  def show
  	# binding.pry
  end

  def index
    @users = nil
    user_role = params['role']
    user_institution = params['institution'] 
    user_program = params['program'] 

    if user_role == ""
      @users = User.all
    else
      @users = User.where(:role => user_role)
    end 

    if user_institution != ""
      @users = @users.where(:current_institution => user_institution)
    end 

    if user_program != ""
      @users = @users.where(:current_program => user_program)
    end 
    
  end

  def edit
    #binding.pry
  end

  def update
    # binding.pry
  end

  def destroy
    binding.pry
    # user_id = params['id']
    # user = User.find_by(:id => user_id)
    # enrollments = Enrollment.where(:user_id => user_id)
    # enrollments.destroy_all
    # team_enrollments = TeamEnrollment.where(:user_id => user_id)
    # team_enrollments.destroy_all
    # user.destroy
    # redirect_to admin_index_path, flash: { success: "Successfully deleted!" }
  end

private

  def create_user
    #params.require(user).permit(:email, :password, :password_confirmation, :role, :first_name, :last_name, :current_program, :current_institution)
  end

end










