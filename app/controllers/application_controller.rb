class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate!

  helper_method :current_user, :form_helper

  def current_user
    @user ||= User.find(session[:user_id])
  end

protected

  def form_helper
    @form_helper ||= FormHelper.new
  end

  def authenticate!
    redirect_to new_session_path unless session[:user_id]
  end


end
