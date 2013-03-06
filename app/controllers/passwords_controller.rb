class PasswordsController < ApplicationController
  skip_before_filter :authenticate!

  before_filter :authenticate_or_token!, :except => [:forgot, :requested, :sent]

  layout :user_or_token

  def edit
    @user || current_user.password_identity || not_found
  end

  def update
  
    identity = user.password_identity
    identity.updating_password = true   
 
    if identity.update_attributes(params[:identity])
      flash[:notice] = 'happy days - password changed'
      if current_user
        redirect_to dashboard_index_path
      else
        redirect_to new_session_path
      end
    else
      flash[:alert] = identity.errors.full_messages.join(", ")
      if current_user
        redirect_to edit_password_path
      else
        redirect_to edit_password_path(tid: params[:tid])
      end 
    end

  end

  def requested
    identity = PasswordIdentity.where(email: params[:email]).first
    
    if identity
      mail = ChangePassword.request_new(identity.user)
      mail.deliver!
      flash[:email] = identity.email 
      redirect_to sent_password_path
    else
      flash[:alert] = "user with email #{params[:email]} not found"
      redirect_to forgot_password_path
    end
  end

  private

  def user
    @user || current_user
  end

  def authenticate_or_token!
    if params[:tid]
      token = Tokens::ForgotPassword.valid(params[:tid]).first
      if token
        @user = token.user
      else
        redirect_to forgot_password_path
      end
    else
      authenticate!
    end
  end

  def user_or_token
    if current_user
      'application'
    else
      'home'
    end
  end

end
