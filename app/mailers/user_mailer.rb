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
    mail(to: "rmarinac89@gmail.com", subject: 'Foobli Support') do |format|
      format.html { render 'support_email' }
    end
  end
end
