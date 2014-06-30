module ApplicationHelper

  def is_active(action)       
    params[:action] == action ? "blue-active" : nil        
  end


end
