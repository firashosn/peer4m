class CreateTeamEnrollments < ActiveRecord::Migration
  def change
    create_table :team_enrollments do |t|

      t.timestamps
    end
  end
end
