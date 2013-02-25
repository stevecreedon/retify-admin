class PasswordsController < ApplicationController

  def edit
    current_user.identities.rentified.first || not_found
  end

  def update
  
    identity = current_user.identities.rentified.first || not_found

    identity.updating_password = true
    
    if identity.update_attributes(params[:identity])
      flash[:notice] = 'happy days - password changed'
      redirect_to dashboard_index_path
    else
      flash[:alert] = identity.errors.full_messages.join(", ")
      redirect_to edit_password_path
    end

  end

end
