class UserMailer < ApplicationMailer
  def send_otp
    @user = params[:user]
    @otp = params[:otp]
    mail(to: @user.email_id, subject: 'Get Art Sign up OTP')
  end
end
