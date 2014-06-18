class Course < ActiveRecord::Base
	require 'CSV'

#

  belongs_to :instructor
  has_many :assignments
  has_many :students
end
