class Course < ActiveRecord::Base


  has_many :enrollments
  has_many :users, :through => :enrollments
  has_many :assignments	

  belongs_to :user

  def get_all_assignments
    return self.assignments 
  end
  
end


