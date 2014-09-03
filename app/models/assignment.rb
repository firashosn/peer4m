class Assignment < ActiveRecord::Base
  belongs_to :course
  has_many :teams

def is_open_for_evaluation
  return self.close_time < Time.current #&& self.open_time > Time.current
end

def get_closing_time_day_difference
  return (self.close_time - Time.current).to_i / 1.day 
end

def update_notification
  binding.pry
end

end
