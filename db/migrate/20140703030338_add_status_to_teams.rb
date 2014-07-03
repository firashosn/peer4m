class AddStatusToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :status, :string
  end
end
