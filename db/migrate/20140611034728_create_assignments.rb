class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.string :name
      t.datetime :open_time
      t.datetime :close_time
      t.text :instructions
      t.references :course, index: true

      t.timestamps
    end
  end
end
