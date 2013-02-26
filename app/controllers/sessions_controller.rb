class SessionsController < ApplicationController
  skip_before_filter :authenticate!

  layout 'home'

  def new
  end

  def create
    user = User.from_omniauth(request.env["omniauth.auth"])
    
    session[:user_id] = user.id
    redirect_to dashboard_index_path, alert: "Happy days - you've come back"
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Bye, see you soon"
  end

  def failure
    redirect_to new_session_path, alert: "Sorry, sign-in failed for this username & password"
  end

end
