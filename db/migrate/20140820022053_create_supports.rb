class CreateSupports < ActiveRecord::Migration
  def change
    create_table :supports do |t|
      t.string :optional_email
      t.string :question

      t.timestamps
    end
  end
end
