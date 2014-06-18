class CreateInstructors < ActiveRecord::Migration
  def change
    create_table :instructors do |t|
      t.string :user_name
      t.string :password

      t.timestamps
    end
  end
end
