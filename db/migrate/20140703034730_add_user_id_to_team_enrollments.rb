class AddUserIdToTeamEnrollments < ActiveRecord::Migration
  def change
    add_column :team_enrollments, :user_id, :integer
  end
end
