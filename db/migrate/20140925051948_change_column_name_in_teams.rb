class ChangeColumnNameInTeams < ActiveRecord::Migration
  def change
  	change_column :teams, :name, :string
  end
end
