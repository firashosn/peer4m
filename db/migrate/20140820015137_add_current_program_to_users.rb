class AddCurrentProgramToUsers < ActiveRecord::Migration
  def change
    add_column :users, :current_program, :string
  end
end
