class SessionsController < ApplicationController
  skip_before_filter :authenticate!

  layout 'home'

  def new
  end

  def create
    auth = request.env["omniauth.auth"]
    #auth[:info].symbolize_keys! if auth[:info]
    #auth[:extra].symbolize_keys! if auth[:extra]
    #auth[:credentials].symbolize_keys! if auth[:credentials]
    
    identity = Identity.find_from_auth(auth).first
    
    if identity
      session[:user_id] = identity.user.id
    else
      
      if current_user
        current_user.add_identity_from_auth(auth)
      else
        user = User.create_with_omniauth(auth)
        session[:user_id] = user.id
      end      
 
    end

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
