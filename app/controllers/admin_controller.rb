class AdminController < ApplicationController

  before_action :authenticate_user!, except: [:show]

  def create
   
    @users = nil
    if params['role'] != "" && params['institution'] != "" && params['program'] != ""
      @users = User.where(:role => params['role'], :current_institution => params['institution'], :current_program => params['program'])
       #binding.pry
    end
    
  	redirect_to admin_index_path(@users)
  end

  def show
  	binding.pry
  end

  def index
    binding.pry
  end

  def edit
    #binding.pry
  end

  def update
    binding.pry
  end

  def destroy
    #binding.pry
  end

  private
    def admin_params
      #binding.pry
      #params.require(:course).permit(:role, :institution, :program)
    end

end
