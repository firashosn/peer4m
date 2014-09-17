class AdminController < ApplicationController

  before_action :authenticate_user!, except: [:show]

  def create
  	binding.pry
  end

  def show
  	  binding.pry
  end

  def index
    @admin = current_user
  end

  def edit
    binding.pry
  end

  def update
    binding.pry
  end

  def destroy
    binding.pry
  end

end
