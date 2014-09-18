class Course < ActiveRecord::Base


  has_many :enrollments
  has_many :users, :through => :enrollments
  has_many :assignments	

  belongs_to :user

  def get_all_assignments
    return self.assignments 
  end

  def get_open_assignments
  	my_assignments = get_all_assignments()
  	open_assignments = []
  	if my_assignments != nil && my_assignments.count > 0
  		my_assignments.each do | assignment |
  			if assignment.is_open_for_evaluation() 
  				open_assignments.push(assignment)
  			end
  		end
  	end
  	return open_assignments
  end
  
  def is_user_already_enrolled(user)
    self.enrollments.find_by(:user_id => user.id)
  end

end


