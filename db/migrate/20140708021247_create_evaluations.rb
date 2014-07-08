class CreateEvaluations < ActiveRecord::Migration
  def change
    create_table :evaluations do |t|
      t.integer :reviewer_id
      t.integer :reviewee_id
      t.integer :quality_of_work
      t.integer :dependability
      t.integer :communication
      t.integer :team_player_skills
      t.integer :work_ethic
      t.string :comment

      t.timestamps
    end
  end
end
