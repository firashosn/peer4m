class Assignment < ActiveRecord::Base
  belongs_to :course
  has_many :teams

def is_open_for_evaluation
  return self.close_time < Time.current 
  #&& self.open_time > Time.current
end

def update_notification
  binding.pry
end

end
