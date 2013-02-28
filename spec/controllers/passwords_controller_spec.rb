require 'spec_helper'

describe PasswordsController do

  it 'should raise a 404 if the current user has no password identity' do
  
    user = FactoryGirl.build(:user)
    user.identities << MockIdentity.new
    user.save!
    
    sign_in user
    
    lambda do 
    	get :edit
    end.should raise_error(ActionController::RoutingError)
  end

end
