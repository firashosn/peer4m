class Team < ActiveRecord::Base

  has_many :team_enrollments
  has_many :users, :through => :team_enrollments
  has_many :evaluations
  belongs_to :assignment

  def get_team_index(assignment_id)
    total_teams = Team.where(:assignment_id => assignment_id)
    return total_teams.count + 1
  end

end
