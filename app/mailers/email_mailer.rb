class EmailMailer < ApplicationMailer
  def email_delivery
    @email = params[:email]
    mail(to: @email.to_address, subject: @email.subject)
  end
end
