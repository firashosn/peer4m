class AddTeamRefToEvaluations < ActiveRecord::Migration
  def change
    add_reference :evaluations, :team, index: true
  end
end
