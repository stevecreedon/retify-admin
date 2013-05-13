class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate!

  helper_method :current_user, :notifications

  layout Proc.new { |controller| request.xhr? ? 'remote' : 'application' }

  def current_user
    @current_user ||= User.where(id: session[:user_id]).first
  end

  def notifications
    @notifications ||= []
  end

protected

  def authenticate!
    redirect_to new_session_path unless current_user
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end
end
