require 'spec_helper'

describe PasswordsController do

  it 'should raise a 404 if the current user has no rentified identity' do
    sign_in create_user(identity: {provider: 'twaddle'})
    
    lambda do 
    	get :edit
    end.should raise_error(ActionController::RoutingError)
  end

end
