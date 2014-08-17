class Notification < ActiveRecord::Base
  belongs_to :user

  enum type: [ :team_created, :ranking_update, :evaluation_deadline_approaching, :evaluated ]

  def get_type_name
  	Notification::types.each do |type|
  		if type[1] == self.notification_type
    		return type[0].humanize
    	end
    end
  end

  def get_created_diff
  	return "5 min ago"
  end

  def get_description()
  	"descrition"
  end
  
  def get_redirect_link()
  	case self.notification_type
  	when Notification.types['team_created']
  		team = Team.find_by(:id => self.link_to_id)
  		assignment = Assignment.find_by(:id => team.assignment_id)
  		team_id = team.id
  		assignment_id = assignment.id
  		course_id = assignment.course_id
  		link_array = [course_id,assignment_id,team_id]
  		return link_array
  	else
  		binding.pry
  	end 
  end

end
