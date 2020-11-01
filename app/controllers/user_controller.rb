class UserController < ApplicationController
  skip_before_action :login_required, only: [:login, :sign_up, :resend_otp, :forgot_password]
  before_action :redirect_to_root, only: [:login, :sign_up, :resend_otp, :forgot_password]
  skip_before_action :check_first_login, only: [:complete_signup]
  
  def login
    @user = User.new
    if request.post?
      @user = User.new(user_params)
      if @user.authenticate
        user = User.active.where("email_id = ?", @user.email_id).first
        user.update(sign_in_count: user.sign_in_count.to_i + 1, dont_validate_password: false)
        session[:user_id] = user.id
        reset_flash_message
        redirect_to (session[:back_path].present? ? session[:back_path] : root_path)
      else
        reset_flash_message
        flash[:danger] = t(:wrong_credentials)
        redirect_to action: :login
      end
    end
  end
  
  def sign_up
    reset_flash_message
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
            flash[:danger] = t(:wrong_otp)
            @step = :otp_send
            render action: :sign_up
          end
        end
      else
        flash[:danger] = "#{t(:account_exist)}. <br>#{view_context.link_to t(:click_here_to_login), login_user_index_path} or #{view_context.link_to t(:click_hereh_to_reset_password), forgot_password_user_index_path}"
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
    reset_flash_message
    unless @current_user.user_detail
      if request.patch?
        @user_detail = @current_user.build_user_detail(user_params[:user_detail])
        email_check = user_params[:email_id] == @current_user.email_id
        if email_check && @user_detail.save
          flash[:success] = t(:signup_completed)
          redirect_to :root
        end
      end
    else
      redirect_to :root
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
        reset_flash_message
        flash[:success] = t(:sent_by_mail)
      else
        reset_flash_message
        flash[:danger] = t(:user_not_found)
        redirect_to action: :forgot_password
      end
    elsif request.patch?
      @user = User.find_by_email_id(user_params[:email_id])
      if @user.update(user_params)
        reset_password_token
        reset_flash_message
        flash[:danger] = t(:password_changed)
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
          reset_flash_message
          flash[:danger] = t(:user_not_found)
          redirect_to action: :forgot_password
        end
      end
    end
  end
  
  def dashboard
    reset_flash_message
    @user_detail = @current_user.user_detail
  end

  def edit
  end

  def register_as_seller
    reset_flash_message
    unless @current_user.is_seller
      @user_detail = @current_user.user_detail
      if request.patch?
        user = User.new(user_params.except(:user_detail))
        if user.authenticate
          if user.email_id == @current_user.email_id
            if @user_detail.update(user_params[:user_detail])
              @current_user.update(is_seller: true, dont_validate_password: false)
              flash[:success] = t(:registered_as_seller)
            end
          end
        else
          @error = true
          flash[:danger] = t(:wrong_credentials)
        end
      end
    else
      flash[:danger] = t(:already_registered_as_seller)
      redirect_to :new_product
    end
  end
  
  private

    def user_params
      params.require(:user).permit(:password, :confirm_password, :email_id, :phone_no, 
        user_detail: [:full_name, :phone_no])
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
