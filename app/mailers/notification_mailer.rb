class NotificationMailer < ActionMailer::Base
  default from: "notifications@kslwatcher.com"

  def new_post(user, search_term, post_url)
    @user = user
    @term_text = search_term
    @post_url = post_url
    mail(to: @user.email, subject: "There's a new update from KSL Notifications!")
  end

end
