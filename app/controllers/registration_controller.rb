class RegistrationController < ApplicationController
  skip_before_filter :authenticate!

  layout 'anonymous'

  def new
    @identity = Identity.new
  end

  def create
    identity = Identity.new(params[:identity].merge(:provider => 'password'))

    if Identity.where(name: identity.name, provider: "password").count > 0
      redirect_to(new_session_path, :notice => "#{identity.email} exists for #{identity.provider}")
      return 
    end

    user = User.new
    user.identities << identity

    user.valid?
    
    puts user.errors.full_messages.inspect
    puts user.identities.first.errors.full_messages.inspect


    if user.save
      session[:user_id] = user.id
      redirect_to root_url, notice: "Signed up"
    else
      redirect_to new_registration_path, :notice => user.errors.full_messages
    end  
  end

end
