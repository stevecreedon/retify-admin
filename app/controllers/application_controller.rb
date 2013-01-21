class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate!

  helper_method :current_user

  def current_user
    @user ||= User.find(session[:user_id])
  end

protected

  def authenticate!
    redirect_to new_session_path unless session[:user_id]
  end


end
