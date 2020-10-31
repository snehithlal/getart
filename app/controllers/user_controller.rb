class UserController < ApplicationController
  before_action :login_required, except: [:login, :sign_up, :resend_otp, :forgot_password]
  before_action :redirect_to_root, only: [:login, :sign_up, :resend_otp, :forgot_password]
  skip_before_action :check_first_login, only: [:complete_signup]
  
  def login
    @user = User.new
    if request.post?
      @user = User.new(user_params)
      if @user.authenticate
        user = User.active.where("email_id = ?", @user.email_id).first
        user.update(sign_in_count: user.sign_in_count.to_i + 1)
        session[:user_id] = user.id
        redirect_to session[:back_path], fallback_location: root_path
      else
        flash[:danger] = "Wrong Credentials"
        redirect_to action: :login
      end
    end
  end
  
  def sign_up
    @user = User.new
    if request.post?
      @user = User.new(user_params) 
      check_user_exists = User.find_by_email_id(@user.email_id).present?
      unless check_user_exists
        unless params[:step].present?
          sent_otp
          @step = :otp_send
        else
          otp = params[:otp].values.join
          if session[:otp]["code"] == otp
            if @user.save
              session[:otp] = nil
              session[:user_id] = @user.id
              redirect_to :root
            else
              @time = (120 - (Time.now.to_time - session[:otp]["sent_time"].to_time)).to_i
              @step = "password_not_match"
              render action: :sign_up
            end
          else
            @time = (120 - (Time.now.to_time - session[:otp]["sent_time"].to_time)).to_i
            flash[:danger] = "Wrong OTP"
            @step = :otp_send
            render action: :sign_up
          end
        end
      else
        flash[:danger] = "Account exist. <br>#{view_context.link_to 'Click here to login', login_user_index_path} or #{view_context.link_to 'Click here to reset password', forgot_password_user_index_path}"
        redirect_to action: :sign_up
      end
    else
      session[:otp] = {}
    end
  end
  
  def resend_otp
    sent_otp
    respond_to :js
  end
  
  def sent_otp
    session[:otp] = {} if session[:otp].nil?
    time_diff = Time.now.to_time - session[:otp]["sent_time"].to_time if session[:otp]["sent_time"].present?
    @time = 120 - time_diff.to_i
    if !(session[:otp]["sent_time"].present?) || time_diff.to_i > 120
      session[:otp]["code"] = rand.to_s[2..5]
      session[:otp]["sent_time"] = Time.now
      @user = User.new(email_id: params[:email_id]) unless @user.present?
      @user.send_otp_by_mail(session[:otp]["code"])
      @time = (120 - (Time.now.to_time - session[:otp]["sent_time"].to_time)).to_i
    end
  end
  
  def complete_signup
    @user_detail = @current_user.build_user_detail()
    if request.patch?
      @user_detail = @current_user.build_user_detail(user_params[:user_detail])
      if @user_detail.save
        redirect_to :root
      end
    end
  end
  
  def logout
    reset_session
    redirect_to :root
  end
  
  def forgot_password
    @user = User.new
    if request.post?
      @user = User.find_by_email_id(user_params[:email_id])
      if @user.present?
        @user.send_password_reset_token_by_mail
        @step = :mail_sent
        flash[:success] = "Sent by mail"
      else
        flash[:danger] = t(:user_not_found)
        redirect_to action: :forgot_password
      end
    elsif request.patch?
      @user = User.find_by_email_id(user_params[:email_id])
      if @user.update(user_params)
        reset_password_token
        flash[:danger] = "Password changed"
        redirect_to :root
      else
        @step = :password_not_match
        render action: :forgot_password
      end
    else
      if params[:reset_password_token].present?
        @user = User.find_by_reset_password_token(params[:reset_password_token])
        if @user.present?
          @step = :token_authenticated
        else
          flash[:danger] = t(:user_not_found)
          redirect_to action: :forgot_password
        end
      end
    end
  end
  
  def dashboard
    @user_detail = @current_user.user_detail
  end

  def edit
  end
  
  private
    def user_params
      params.require(:user).permit(:password, :confirm_password, :email_id, :phone_no, :user_detail => [:full_name, :phone_no, :email_id])
    end
    
    def reset_session
      session[:user_id] = nil
    end
    
    def redirect_to_root
      if session[:user_id].present?
        redirect_to :root
      end
    end
    
    def reset_password_token
      @user.update(reset_password_token: nil, reset_password_sent_at: nil, dont_validate_password: false)
    end
end
