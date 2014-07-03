class AddEnrollmentPasswordToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :enrollment_password, :string
  end
end
