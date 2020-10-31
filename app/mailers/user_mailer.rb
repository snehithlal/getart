class UserMailer < ApplicationMailer
  def send_otp
    @user = params[:user]
    @otp = params[:otp]
    mail(to: @user.email_id, subject: 'Get Art Sign up OTP')
  end
  
  def send_password_reset_token
    @user = params[:user]
    @user.update(reset_password_sent_at: Time.now, dont_validate_password: false)
    mail(to: @user.email_id, subject: 'Get Art Password Reset')
  end
end
