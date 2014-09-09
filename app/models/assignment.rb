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

  def get_assignment_review_status_string
    all_teams = self.teams
    total_num_teams = all_teams.count
    teams_completed = 0
    all_teams.each do |team|
      team_status = team.get_team_review_status_string
      if team_status == "completed"
        teams_completed += 1
      end
    end

    if teams_completed > 0 && teams_completed == total_num_teams
      return "completed"
    else
      return " " + teams_completed.to_s + " / " + (total_num_teams).to_s
    end
  end


end
