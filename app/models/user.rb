class User < ActiveRecord::Base


#insructor is enrolled, but his role is instructor

	has_many :enrollments
  has_many :courses
  has_many :teams
	# has_many :courses, :through => :enrollments

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  after_initialize :add_default_role

  ROLES = ['administrator', 'student', 'instructor' ]

  validates :role, inclusion: ROLES

  def add_default_role
  	self.role = 'instructor' if self.role.nil?
  end

  def enrolled_courses
    self.enrollments.map(&:course)
  end

  #attr_accessible :email, :encrypted_password, :role

  #enum :role, [:administrator, :instructor, :student] 
  #validates_enum :role
end
