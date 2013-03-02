class RegistrationController < ApplicationController
  skip_before_filter :authenticate!

  layout 'home'

  def new
    @identity = Identity.new
  end

  def create

    if PasswordIdentity.where(email: params[:identity][:email], provider: "password").count > 0
      redirect_to(new_session_path, alert: "#{params[:identity][:email]} exists")
      flash[:email] = params[:identity].try(:[], :email)
      flash[:alert] = "you've already signed-up, please login here"
      return 
    end

    user = User.new

    identity = PasswordIdentity.new(params[:identity])
    identity.updating_password = true
    identity.confirm = identity.password #we don't confirm password on sign-up..

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
    token = Tokens::ValidateEmail.where(guid: params[:id]).first!
    user = token.user
    identity = user.password_identity
    identity.verify!
    render :nothing => true 
  end

end
