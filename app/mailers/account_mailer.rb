class AccountMailer < ApplicationMailer
  default from: 'greenpoint_noreply@gmail.com'

  def verification_email
    @user = params[:user]
    mail(to: @user.email, subject: 'Registration Confirmation')
  end

  def forgot_email
    @user = params[:user]
    mail(to: @user.email, subject: 'Reset your password')
  end
end
