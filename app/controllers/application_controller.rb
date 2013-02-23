class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate!
  before_filter :check_account_for_user

  helper_method :current_user, :form_helper, :notifications

  layout Proc.new { |controller| request.xhr? ? 'remote' : 'application' }

  def current_user
    @current_user ||= User.where(id: session[:user_id]).first
  end

  def notifications
    @notifications ||= []
  end

protected

  def form_helper
    @form_helper ||= FormHelper.new
  end

  def authenticate!
    redirect_to new_session_path unless session[:user_id]
  end

  def check_account_for_user
    if current_user && !(current_user.phone && current_user.address)
      redirect_to edit_account_path(current_user.id)
    end
  end
end
