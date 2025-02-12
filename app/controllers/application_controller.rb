class ApplicationController < ActionController::Base
  helper_method :current_user # Make this method available in views

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
end