class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.integer :name
      t.references :assignment, index: true

      t.timestamps
    end
  end
end
