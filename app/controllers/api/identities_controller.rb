class Api::IdentitiesController < ApplicationController
  def create
    identity                   = current_user.password_identity
    identity.updating_password = true   
    identity.password          = params[:password]
    identity.confirm           = params[:confirm]
 
    status = identity.save ? 200 : 400
    render json: identity, status: status
  end
end
