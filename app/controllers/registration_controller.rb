class RegistrationController < ApplicationController
  skip_before_filter :authenticate!

  layout 'home'

  def new
    @identity = PasswordIdentity.new
  end

  def create

    if PasswordIdentity.where(email: params[:password_identity][:email]).count > 0
      redirect_to(new_session_path, alert: "#{params[:password_identity][:email]} exists")
      flash[:email] = params[:password_identity].try(:[], :email)
      flash[:alert] = "you've already signed-up, please login here"
      return 
    end

    user = User.new

    user.build_password_identity(params[:password_identity])
    user.password_identity.updating_password = true
    user.password_identity.confirm = user.password_identity.password #we don't confirm password on sign-up so just make them the same..

    if user.save
      session[:user_id] = user.id
      redirect_to edit_account_path(user.id), notice: "welcome to loveBnB, we hope you'll come back often"
    else
      flash[:email] = params[:password_identity].try(:[], :email)
      redirect_to new_registration_path, alert: "sorry we couldn't sign you up because: #{user.password_identity.errors.full_messages.join(" ")}"
    end
  end

  def verify
    token = Tokens::ValidateEmail.where(guid: params[:id]).first!
    token.password_identity.verify!

    redirect_to dashboard_index_path, notice: 'your email is verified now'
  end

end
