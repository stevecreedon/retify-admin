class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate!


  def authenticate!
    return if params[:controller] == "sessions"
    redirect_to new_session_path unless session[:user_id]
  end


end
