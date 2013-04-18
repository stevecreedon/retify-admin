class ApiController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate!

  def default_serializer_options
    {
      root: false
    }
  end

private

  def current_user
    @current_user ||= User.where(id: session[:user_id]).first
  end

  def authenticate!
    render json: { error: 'Please login' }, status: 401 unless current_user
  end
end
