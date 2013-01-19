class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate!


  def current_user
    @user ||= User.find(session[:user_id])
  end

  def authenticate!
    return if params[:controller] == "sessions"
    redirect_to new_session_path unless session[:user_id]
  end


end
