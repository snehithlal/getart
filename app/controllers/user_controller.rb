class UserController < ApplicationController
  before_action :login_required, except: [:login, :sign_up]
  before_action :redirect_to_root, only: [:login, :sign_up]
  
  def login
    @user = User.new
    if request.post?
      @user = User.new(user_params)
      if @user.authenticate
        user = User.active.where("email_id = ?", @user.email_id).first
        session[:user_id] = user.id
        flash[:notice] = "Welcome #{user.user_detail.full_name}" 
      else
        flash[:danger] = "Wrong Credentials"
      end
      redirect_to :root
    end
  end
  
  def sign_up
    @user = User.new
    if request.post?
      @user = User.new(user_params) 
      unless params[:step].present?
        p session[:otp] = rand.to_s[2..5]
        @user.send_otp_by_mail(session[:otp])
        @step = :otp_send
      else
        otp = params[:otp].values.join
        if session[:otp] == otp
          if @user.save
            session[:otp] = nil
            session[:user_id] = @user.id
            flash[:notice] = "Welcome #{@user.full_name}"
            redirect_to :root
          end
        else
          flash[:error] = "Wrong OTP. Click here to Resend OTP"
          @step = :otp_send
          render action: :sign_up
        end
      end
    end
  end
  
  def logout
    reset_session
    redirect_to :root
  end
  
  def dashboard
    @user_detail= @current_user.user_detail
  end
  
  private
    def user_params
      params.require(:user).permit(:full_name, :password, :confirm_password, :email_id, :phone_no)
    end
    
    def reset_session
      session[:user_id] = nil
    end
    
    def redirect_to_root
      if session[:user_id].present?
        redirect_to :root
      end
    end
end