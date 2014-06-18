class Student < ActiveRecord::Base
	has_and_belongs_to_many :courses
	has_many :teams
	has_many :assignments, :through => :courses
end
