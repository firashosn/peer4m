class Course < ActiveRecord::Base
#	require 'CSV'

  has_many :enrollments
  has_many :users, :through => :enrollments
  has_many :assignments	
  
end

#Instruction sets up many users to a Course

# Users
# 1 
# 2
# 3
# 4
# 5
# 6
# 7

# User_Courses (enrollments)
# 1   4    $20
# 2 	5
# 2   6
# 2    
# 2



# Courses
# 4
# 5
# 6
# 8
# 9
# 10


