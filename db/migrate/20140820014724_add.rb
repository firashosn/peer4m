class Add < ActiveRecord::Migration
  def change
    add_column :users, :current_institution, :string
  end
end
