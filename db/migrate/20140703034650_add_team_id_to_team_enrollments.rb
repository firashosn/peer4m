class AddTeamIdToTeamEnrollments < ActiveRecord::Migration
  def change
    add_column :team_enrollments, :team_id, :integer
  end
end
