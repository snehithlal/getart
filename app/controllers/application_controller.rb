class ApplicationController < ActionController::Base
  before_action :current_user
  private
  
    def current_user
      @current_user ||= User.find_by_id(session[:user_id])
    end
    
    def login_required
      redirect_to login_user_index_path unless session[:user_id].present?
    end
end
