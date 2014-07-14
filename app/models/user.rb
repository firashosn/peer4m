class User < ActiveRecord::Base


#insructor is enrolled, but his role is instructor

	has_many :enrollments
  has_many :courses
  has_many :team_enrollments
  has_many :teams, :through => :team_enrollments
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

  def is_already_reviewed(team_id,reviewee_id)
    review_exists = Evaluation.find_by(:team_id => team_id, :reviewer_id => self.id, :reviewee_id => reviewee_id)
    return review_exists != nil
  end

  #attr_accessible :email, :encrypted_password, :role

  #enum :role, [:administrator, :instructor, :student] 
  #validates_enum :role
end
