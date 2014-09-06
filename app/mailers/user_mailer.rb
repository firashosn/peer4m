class UserMailer < ActionMailer::Base
  default from: "info@foobli.com"

  def welcome_email(user)
    @user = user
    @url  = 'http://foobli.com/login'
    mail(to: @user.email, subject: 'Welcome to Foobli') do |format|
      format.html { render 'welcome_email' }
    end
  end

  def support_email(user, question)
    @user = user
    @question = question
    @url = 'http://foobli.com/support/new'
    mail(to: @user.email, subject: 'Foobli Support') do |format|
      format.html { render 'support_email' }
    end
  end

  def notification_new_team_email(user)
    @user = user
    # @url = course_assignment_teams_path(@course, assignment)
    mail(to: user.email, subject: 'New Team') do |format|
      format.html { render 'notification_new_team_email' }
    end
  end
end
