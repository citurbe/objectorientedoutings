class PlanMailer < ApplicationMailer

  def time_to_go(user, message)
    @user = user
    @message = message
    mail(to: @user.email, subject: "Time to go!")
  end
end
