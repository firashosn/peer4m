class Student < ActiveRecord::Base
	has_and_belongs_to_many :courses
	has_many :assignments, :through => :courses
	has_many :teams, :through => :assignments
end
