class Notification < ActiveRecord::Base
  belongs_to :user

  enum type: [ :team_created, :ranking_update, :evaluation_period_open, :evaluation_deadline_approaching, :evaluated, :welcome, :team_evaluated ]



  def get_type_name
  	Notification::types.each do |type|
      if self.notification_type == Notification.types['welcome']
        return "Welcome to Foobli"
  		elsif type[1] == self.notification_type
    		return type[0].humanize
    	end
    end
  end

  def get_created_diff

    created_time = self.created_at
    created_time_diff = Time.current - created_time
    if created_time_diff < 60 
      return created_time_diff.round(0).to_s + " seconds ago"
    elsif created_time_diff < 3600
      minute_diff = created_time_diff/60
      return minute_diff.round(0).to_s + " minutes ago"
    elsif created_time_diff < 86400
      hour_diff = created_time_diff/3600
      return hour_diff.round(0).to_s + " hours ago"
    elsif created_time_diff < 172800
      return "Yesterday at " + created_time.strftime("%H:%M")
    end

    return created_time.strftime("%B %d at %H:%M")

  end

  def get_description()
  	team = Team.find_by(:id => self.link_to_id)
    if self.notification_type == Notification.types['welcome']
      return "Find your notifications here"
    elsif team != nil
      assignment = Assignment.find_by(:id => team.assignment_id)
      if assignment != nil
      course_id = assignment.course_id
      course = Course.find_by(:id => course_id)
      return course.course_name + " , " + assignment.name
      end
    end
    
    return ""
    
    
  end
  
  def get_redirect_link()
  	case self.notification_type
    	when Notification.types['team_created'], Notification.types['evaluation_period_open'],Notification.types['evaluation_deadline_approaching'],Notification.types['team_evaluated']
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
      when Notification.types['evaluated']
        link_array = nil
      when Notification.types['welcome']
        link_array = nil
    	else
    		return nil
    end 
    return nil
  end

end
