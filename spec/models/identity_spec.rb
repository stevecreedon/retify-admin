require 'spec_helper'

describe Identity do
 
  context 'other provider' do
              
    it 'should not send a verification email on creation for a non-password provider' do
      user = FactoryGirl.build(:user)
      identity = GoogleIdentity.new
      user.google_identity = identity   

      mail_delivery do
        user.save!
      end.should_not be_true
    end

    context 'create from auth' do

      it 'should return a password identity class' do

        identity = Identity.create_from_auth("provider" => "password", "uid" => "abcdefghi", "info" => {"email" => 'steve@testxyz.com', "name" => "stevey steve"})
        identity.should be_a(PasswordIdentity)

      end

    end
  end   
end 
