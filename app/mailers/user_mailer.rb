class UserMailer < ActionMailer::Base

  def welcome_email(user)
    @user = user
    @url  = 'http://foobli.com/login'
    mail(from:"info@foobli.com", to: @user.email, subject: 'Welcome to Foobli') do |format|
      format.html { render 'welcome_email' }
    end
  end

  def support_email(user, question)
    @user = user
    @question = question
    @url = 'http://foobli.com/support/new'
    mail(from: @user.email, to: "rocco@foobli.com, firas@foobli.com", subject: 'Foobli Support') do |format|
      format.html { render 'support_email' }
    end
  end

  #this is for the prof
  def notification_team_evaluated_email(user,course,assignment,team)
    @user = user
    @team = team
    @course = course
    @assignment = assignment
    @url = 'http://foobli.com/'
    # course_assignment_teams_path(course.id, assignment.id, team.id)
    mail(from:"info@foobli.com", to: user.email, subject: 'Team: ' + team.name.to_s + ' Evaluated ' + course.course_id + ' - ' + assignment.name) do |format|
      format.html { render 'notification_new_team_email' }
    end
  end

  #this is when the students have finished the evaluation
  def notification_student_evaluated_email(user,course,assignment,team)
    @user = user
    @url = 'http://foobli.com/'
    # course_assignment_teams_path(course.id, assignment.id, team.id)
    mail(from:"info@foobli.com", to: user.email, subject: 'You have been evaluated: ' + course.course_id + ' - ' + assignment.name) do |format|
      format.html { render 'notification_new_team_email' }
    end
  end

  def notification_new_team_email(user,course,assignment,team)
    @user = user
    @url = 'http://foobli.com/'
    # course_assignment_teams_path(course.id, assignment.id, team.id)
    mail(from:"info@foobli.com", to: user.email, subject: 'New Team Created: ' + course.course_id + ' - ' + assignment.name) do |format|
      format.html { render 'notification_new_team_email' }
    end
  end


  def notification_eval_open_email(user,course_id,assignment_id,team_id)
    @user = user
    @url = 'http://foobli.com/'
    # course_assignment_teams_path(course_id, assignment_id, team_id)
    mail(from:"info@foobli.com", to: user.email, subject: 'Evaluation Open') do |format|
      format.html { render 'notification_eval_open_email' }
    end
  end

  def notification_deadline_approaching_email(user,course_id,assignment_id,team_id)
    @user = user
    @url = 'http://foobli.com/'
    # course_assignment_teams_path(course_id, assignment_id, team_id)
    mail(from:"info@foobli.com", to: user.email, subject: 'Deadline Approaching') do |format|
      format.html { render 'notification_eval_open_email' }
    end
  end

end
