class ApplicationController < ActionController::Base
  helper_method :current_user # Make this method available in views

    # Custom method to check if a user is logged in
    def authenticate_user!
      unless current_user
        redirect_to login_path, alert: "You need to log in to access this page."
      end
    end

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
end
