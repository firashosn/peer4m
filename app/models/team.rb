class Team < ActiveRecord::Base

  has_many :team_enrollments
  has_many :users, :through => :team_enrollments
  has_many :evaluations
  belongs_to :assignment

  def get_team_index(assignment_id)
    total_teams = Team.where(:assignment_id => assignment_id)
    return total_teams.count + 1
  end

  def get_team_users
    user_rows = TeamEnrollment.where(:team_id => self.id)
    if user_rows != nil && user_rows.count > 0
      user_ids = user_rows.pluck('user_id')
      return user_ids
    end
    return nil
  end

end
