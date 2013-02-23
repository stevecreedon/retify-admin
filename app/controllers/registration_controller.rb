class RegistrationController < ApplicationController
  skip_before_filter :authenticate!

  layout 'home'

  def new
    @identity = Identity.new
  end

  def create

    if Identity.where(email: params[:identity][:email], provider: "password").count > 0
      redirect_to(new_session_path, alert: "#{params[:identity][:email]} exists")
      flash[:email] = params[:identity].try(:[], :email)
      return 
    end

    user = User.new
    user.identities.build(params[:identity].merge(:provider => 'password'))

    if user.save
      session[:user_id] = user.id
      redirect_to dashboard_index_path, notice: "welcome to micro hotels"
    else
      flash[:email] = params[:identity].try(:[], :email)
      redirect_to new_registration_path, alert: "sign up failed #{user.errors.full_messages.join(" ")}"
    end  
  end

  def verify
    user = User.where(guid: params[:id]).first!
    identity = user.identities.rentified.first!
    identity.email_verified = true
    identity.save!
    render :nothing => true 
  end

end
