class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate!
  before_filter :check_account_for_user
  before_filter :set_notifications

  helper_method :current_user, :notifications

  layout Proc.new { |controller| request.xhr? ? 'remote' : 'dashboard' }

  def current_user
    @current_user ||= User.where(id: session[:user_id]).first
  end

  def notifications
    @notifications ||= []
  end

protected

  def set_notifications
    if current_user && current_user.password_identity.try(:verifying?)
      notifications << "please verify your email address"
    end
  end

  def authenticate!
    redirect_to new_session_path unless current_user
  end

  def check_account_for_user
    if current_user.try(:account_incomplete?)
      redirect_to edit_account_path(current_user.id)
    end
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end
end
