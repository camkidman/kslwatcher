class NotificationMailer < ActionMailer::Base
  default from: "updates@kslnotifications.com"

  include SendGrid
  sendgrid_category :use_subject_lines
  sendgrid_enable   :ganalytics, :opentrack

  def new_post(user, search_term, post_url)
    sendgrid_category "New Post"
    @user = user
    @term_text = search_term.term
    @post_url = post_url
    mail(to: @user.email, subject: "There's a new update from KSL Notifications!")
  end

end
