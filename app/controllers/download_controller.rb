class DownloadController < ApplicationController
  
  before_filter :login_required

  def index
  end
  
  def download
    send_file '/private/Foobli-Rubric.pdf', :type=>"application/Foobli-Rubric.pdf", :x_sendfile=>true
  end

end