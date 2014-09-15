class Team < ActiveRecord::Base

  has_many :team_enrollments
  has_many :users, :through => :team_enrollments
  has_many :evaluations
  belongs_to :assignment

  def get_team_index(assignment_id)
    total_teams = Team.where(:assignment_id => assignment_id)
    return total_teams.count + 1
  end

  def get_team_users
    user_rows = TeamEnrollment.where(:team_id => self.id)
    if user_rows != nil && user_rows.count > 0
      user_ids = user_rows.pluck('user_id')
      return user_ids
    end
    return nil
  end

  def get_is_peer_reviews_of_user_completed(reviewee_id)
      user_rows = TeamEnrollment.where(:team_id => self.id)
      if(user_rows != nil && user_rows.count > 0)
        user_rows.each do |user_row|
          if(user_row.user_id != reviewee_id)
            if self.is_user_done_reviews(user_row.id) == false
              return false
            end
          end
        end
        return true
      end
      return false
  end

  def get_team_review_status_string
      user_rows = TeamEnrollment.where(:team_id => self.id)
      total_team_members_for_review = user_rows.count - 1
      all_reviewees = self.evaluations.pluck('reviewee_id')
      completed_reviews = 0
      if all_reviewees.count > 0 && total_team_members_for_review > 0
        user_rows.each do |user_row|
          user_id = user_row.user_id
          reviews_for_current_student = all_reviewees.select { |a| a == user_id }
          if reviews_for_current_student.count == total_team_members_for_review
            completed_reviews += 1
          end
        end
      end

      if completed_reviews > 0 &&  completed_reviews > total_team_members_for_review
        return "completed"
      else
        return " " + completed_reviews.to_s + " / " + (total_team_members_for_review+1).to_s
      end
  end

  def is_user_done_reviews(user_id)
      user_rows = TeamEnrollment.where(:team_id => self.id)
      total_team_members_for_review = user_rows.count - 1
      all_reviews = self.evaluations.pluck('reviewer_id')
      completed_reviews = all_reviews.count
      if completed_reviews > 0 && total_team_members_for_review > 0 && completed_reviews == total_team_members_for_review
        return true
      end

      return false
  end

end
