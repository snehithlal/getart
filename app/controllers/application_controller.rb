class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :current_user
  helper_method :current_user
  private
  
    def current_user
      @current_user ||= User.find_by_id(session[:user_id])
    end
    
    def login_required
      unless session[:user_id].present?
        back_path = request.path.split("/").select {|x| x.present?}
        session[:back_path] = url_for(controller: back_path[0], action: back_path[1]) 
        redirect_to login_user_index_path
      end
    end
end
