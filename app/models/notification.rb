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

    created_time = self.created_at
    created_time_diff = Time.current - created_time
    
    if created_time_diff < 60 
      return created_time_diff.to_s + " seconds ago"
    elsif created_time_diff < 3600
      minute_diff = created_time_diff/60
      return minute_diff.to_s + " minutes ago"
    elsif created_time_diff < 86400
      hour_diff = created_time_diff/3600
      return minute_diff.to_s + " hours ago"
    elsif created_time_diff < 172800
      return "Yesterday at " + created_time.strftime("%H:%M")
    end

    return created_time.strftime("%B %d at %H:%M")

  end

  def get_description()
  	team = Team.find_by(:id => self.link_to_id)
    assignment = Assignment.find_by(:id => team.assignment_id)
    course_id = assignment.course_id
    course = Course.find_by(:id => course_id)
    return course.course_name + " , " + assignment.name
    
  end
  
  def get_redirect_link()
  	case self.notification_type
  	when Notification.types['team_created']
  		team = Team.find_by(:id => self.link_to_id)
      if team != nil
  		  assignment = Assignment.find_by(:id => team.assignment_id)
        if assignment != nil
    		  team_id = team.id
    		  assignment_id = assignment.id
    		  course_id = assignment.course_id
    		  link_array = [course_id,assignment_id,team_id]
    		  return link_array
        end
      end
  	else
  		return nil
  	end 
    return nil
  end

end
