class RegistrationController < ApplicationController
  skip_before_filter :authenticate!

  layout 'anonymous'

  def new
    @identity = Identity.new
  end

  def create
    identity = Identity.new(params[:identity].merge(:provider => 'password'))

    if Identity.where(name: identity.name, provider: "password").count > 0
      redirect_to(new_session_path, :alert => "#{identity.name} exists")
      return 
    end

    user = User.new
    user.identities << identity

    user.valid?
    
    puts user.errors.full_messages.inspect
    puts user.identities.first.errors.full_messages.inspect


    if user.save
      session[:user_id] = user.id
      redirect_to root_url, notice: "welcome to micro hotels"
    else
      redirect_to new_registration_path, alert: "sign up failed #{user.full_messages.join(" ")}"
    end  
  end

end
