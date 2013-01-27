class RegistrationController < ApplicationController
  skip_before_filter :authenticate!

  layout 'anonymous'

  def create
    redirect_to(new_session_path, :notice => "#{params["registrations"]["email"]} exists" ) if User.where(email: params["registrations"]["email"]).count > 0
    user = User.new(params[:registrations])
    
    if user.save
      session[:user_id] = user.id
      redirect_to root_url, notice: "Signed up"
    else
      redirect_to new_registration_path, :notice => user.errors.full_messages
    end  
  end

end
