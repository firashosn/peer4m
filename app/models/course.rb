class Course < ActiveRecord::Base
#	require 'CSV'

  has_many :enrollments
  has_many :users, :through => :enrollments
  has_many :assignments	

  belongs_to :user
  
end


