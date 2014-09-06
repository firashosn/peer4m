class Assignment < ActiveRecord::Base
  belongs_to :course
  has_many :teams

def is_open_for_evaluation
  if self.close_time != nil && self.open_time != nil
    return self.close_time > Time.current && self.open_time < Time.current
  end
  
  return 0
end

def get_closing_time_day_difference
  if self.close_time != nil 
    return (self.close_time - Time.current).to_i / 1.day 
  end

  return 0

end

def update_notification
  binding.pry
end

end
