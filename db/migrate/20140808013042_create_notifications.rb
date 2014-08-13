class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :type
      t.datetime :opened_time
      t.integer :link_to_id
      t.references :user, index: true

      t.timestamps
    end
  end
end
