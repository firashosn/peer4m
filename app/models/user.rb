class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, 
         :validatable


  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i


  validates :first_name, 
            :last_name,
            presence:true,
            format: { with: /[a-zA-Z]/, message: 'Please only use letters' }



#insructor is enrolled, but his role is instructor
  # has_one :user_info
	has_many :enrollments
  has_many :courses
  has_many :team_enrollments
  has_many :teams, :through => :team_enrollments
  has_many :notifications
  has_many :supports
	# has_many :courses, :through => :enrollments

  

  after_initialize :add_default_role

  ROLES = ['administrator', 'student', 'instructor' ]

  ROLES_DROPDOWN = [ ['Select Role' , ''] , ['Instructor', 'instructor'], ['Student', 'student'] ]

  INSTITUTIONS = [ ['Select Institution' , ''] , ['York University', 'York University'], ['George Brown University', 'George Brown University'] ]

  PROGRAMS = [ ['Select Program', ''], ['Business', 'Business' ], ['Game Development', 'Game Development'] ]

  EVALUATION_FIELDS = ['quality_of_work','dependability','communication','team_player_skills','work_ethic']

  validates :role, inclusion: ROLES

  def add_default_role
  	self.role = 'student' if self.role.nil?
  end

  def enrolled_courses
    return self.enrollments.map(&:course)
  end

  def self.are_students
    return User.where(:role => 'student')
  end

  def poll_evaluation_open
    en_courses = self.enrolled_courses
    if en_courses.count > 0
      en_courses.each do |course|
        open_assignments = course.get_open_assignments()
        if open_assignments.count > 0 
          open_assignments.each do |assignment|
            my_team = assignment.get_user_team(self)
            if my_team != nil && !my_team.is_user_done_reviews(self.id)
              is_notification_already_created = self.notifications.find_by(:link_to_id => my_team.id, :notification_type => Notification.types['evaluation_period_open'])
              if is_notification_already_created == nil
                self.notifications.create(:link_to_id => my_team.id, :user_id => self.id, :notification_type => Notification.types['evaluation_period_open'])
                UserMailer.notification_eval_open_email(self,course.id,assignment.id,my_team.id).deliver
              end
            end
          end
        end
      end
    end
  end

  def poll_evaluation_deadline_approaching
    en_courses = self.enrolled_courses
    if en_courses!= nil && en_courses.count > 0
      en_courses.each do |course|
        open_assignments = course.get_open_assignments()
        if open_assignments.count > 0 
          open_assignments.each do |assignment|
            my_team = assignment.get_user_team(self)
            if my_team != nil && !my_team.is_user_done_reviews(self.id)
              diff_in_days = assignment.get_closing_time_day_difference()
              if diff_in_days <= 3
               self.notifications.create(:link_to_id => my_team.id, :user_id => self.id, :notification_type => Notification.types['evaluation_deadline_approaching'])
                UserMailer.notification_deadline_approaching_email(self,course.id,assignment.id,my_team.id).deliver
              end
            end
          end
        end
      end
    end
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
        return avg.round(1)
    else
      return 0
    end
  end

  def get_evaluation_field_for_reviewee_with_reviewer_id_and_team_id(eval_field,reviewer_id,reviewee_id, team_id)
    review = Evaluation.find_by(:reviewee_id => reviewee_id, :reviewer_id => reviewer_id, :team_id => team_id)
    if review.nil? 
        return 0
    else
      field = review[eval_field]
      return field
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

  def get_assignment_evaluation_field_average(assignment, eval_field)
    is_comment = eval_field == "comment"
    if assignment.teams != nil && assignment.teams.count > 0
      assignment_teams = assignment.teams.pluck(:id)
      user_teams = self.team_enrollments.map(&:team)
      user_team_ids = user_teams.map(&:id)
      user_assignment_team_id = user_team_ids & assignment_teams
      all_reviews = Evaluation.where(:team_id => user_assignment_team_id, :reviewee_id => self.id)
      if all_reviews.count > 0
        if is_comment
          all_comments = all_reviews.pluck('comment')
        else
          all_reviews_for_field = all_reviews.pluck(eval_field)
          avg = all_reviews_for_field.sum.to_f/all_reviews_for_field.length
          return avg.round(1)
        end
      else
        return 0
      end
    end
  end

  def get_num_new_notifications()
    new_notifications = self.notifications.where(:opened_time => nil)
    return new_notifications.count 
  end

  def get_current_notifications()

    if self.notifications.count == 0
      return nil
    end

    new_notifications = self.notifications.where(:opened_time => nil)
    new_notification_count = new_notifications.count

    #self.notifications.order(created_at: :desc)
    #current_notifications = self.notifications.limit(new_notification_count + 5)

    new_notifications.each do |new_notification|
      new_notification.opened_time = Time.current
      new_notification.save
    end

    current_notifications = self.notifications.limit(new_notification_count + 5)
    current_notifications = self.notifications.order(created_at: :desc)

    return current_notifications
  end

end
