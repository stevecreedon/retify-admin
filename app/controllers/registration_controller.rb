class RegistrationController < ApplicationController
  skip_before_filter :authenticate!

  layout 'anonymous'

  def new
    @identity = Identity.new
  end

  def create
    if Identity.where(email: params[:identity][:email], provider: "password").count > 0
      redirect_to(new_session_path, alert: "#{params[:identity][:email]} exists")
      return 
    end

    identity = Identity.create params[:identity].merge(:provider => 'password')

    user = User.new
    user.identities << identity

    if user.save
      session[:user_id] = user.id
      redirect_to root_url, notice: "welcome to micro hotels"
    else
      redirect_to new_registration_path, alert: "sign up failed #{user.errors.full_messages.join(" ")}"
    end  
  end

end
