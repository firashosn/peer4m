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

  EVALUATION_FIELDS = ['quality_of_work','dependability','communication','team_player_skills','work_ethic']

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

  def get_evaluation_field_average(eval_field)
    all_reviews = Evaluation.where(:reviewee_id => self.id)
    if all_reviews.count > 0
        all_reviews_for_field = all_reviews.pluck(eval_field)
        avg = all_reviews_for_field.sum.to_f/all_reviews_for_field.length
        return avg
    else
      return 0
    end
  end

  def get_all_comments
    all_reviews = Evaluation.where(:reviewee_id => self.id)
    if all_reviews.count > 0
      #add team name and assignment name 
        all_comments = all_reviews.pluck('comment')
        return all_comments
    else
      return 0
    end
  end

  #attr_accessible :email, :encrypted_password, :role

  #enum :role, [:administrator, :instructor, :student] 
  #validates_enum :role
end
