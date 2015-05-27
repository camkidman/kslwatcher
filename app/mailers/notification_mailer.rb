class NotificationMailer < ActionMailer::Base
  default from: "notifications@kslwatcher.com"

  class UserMailer < ApplicationMailer
    default from: 'notifications@example.com'

    def welcome_email(user)
      @user = user
      @url  = 'http://example.com/login'
      mail(to: @user.email, subject: 'Welcome to My Awesome Site')
    end
  end
end
