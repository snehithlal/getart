class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :current_user
  before_action :check_first_login
  helper_method :current_user
  helper_method :reset_flash_message
  private
  
    def current_user
      @current_user ||= User.find_by_id(session[:user_id])
    end
    
    def check_first_login
      if @current_user && !@current_user.user_detail
        redirect_to controller: :user, action: :complete_signup
      end
    end
    
    def login_required
      unless session[:user_id].present?
        back_path = request.path.split("/").select {|x| x.present?}
        session[:back_path] = url_for(controller: back_path[0], action: back_path[1]) 
        redirect_to login_user_index_path
      end
    end
    
    def reset_flash_message
      [:blue_notice, :lightgrey_notice, :success, :danger, :warning, :info,
        :light, :dark].each do |x|
        flash[x] = nil
      end
    end
end
