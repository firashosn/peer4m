class SupportController < ApplicationController

def index
end

def new

end

def create
  my_params = params[:support]
  question = my_params[:question]
  UserMailer.support_email(current_user, question).deliver
  redirect_to new_support_path, flash: { :success => "Support message sent" } 
end



end