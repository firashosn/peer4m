class CreateUserInfos < ActiveRecord::Migration
  def change
    create_table :user_infos do |t|
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :current_institution
      t.string :current_program
      t.datetime :enrollment_date
      t.string :gender

      t.timestamps
    end
  end
end
