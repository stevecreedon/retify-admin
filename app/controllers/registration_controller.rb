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
      flash[:alert] = "you've already signed-up, please login here"
      return 
    end

    user = User.new 
    identity = Identity.new(params[:identity].merge(:provider => 'password'))
    identity.extend(PasswordIdentity)
    identity.confirm = params[:identity].try(:[], :password) 
    user.identities << identity

    if user.save
      session[:user_id] = user.id
      redirect_to edit_account_path(user.id), notice: "welcome to loveBnB, we hope you'll come back often"
    else
      flash[:email] = params[:identity].try(:[], :email)
      redirect_to new_registration_path, alert: "sorry we couldn't sign you up because: #{identity.errors.full_messages.join(" ")}"
    end
  end

  def verify
    user = User.where(guid: params[:id]).first!
    identity = user.identities.rentified.first!
    identity.verify!
    render :nothing => true 
  end

end
