require 'spec_helper'

describe RegistrationController do

  context 'destroy' do

    it 'should destroy the current user if the account is incomplete' do
      user = FactoryGirl.create(:user_with_verified_identity)
      user.update_attribute(:address, nil)
      user.update_attribute(:phone, nil)
      sign_in user
      lambda do
        delete :destroy, :id => user.id
      end.should change(User,:count).by(-1)
      User.exists?(user.id).should be_false
      response.should redirect_to root_path  
    end

    it 'should raise an error if the account is complete' do
      user = FactoryGirl.create(:user_with_verified_identity)
      sign_in user
      lambda do
        delete :destroy, :id => user.id
      end.should raise_error(RuntimeError, "cannot destroy a good account")
    end  

  end

  


end
