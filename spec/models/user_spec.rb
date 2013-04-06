require 'spec_helper'

describe User do
  
  context 'password identity' do

    let(:user){FactoryGirl.build(:user)}

    it 'should return an identity if the user has a password identity' do
      identity = FactoryGirl.build(:password_identity)
      user.identities << identity
      user.save!
      user.password_identity.should == identity
    end

    it 'should not be true if the identity is not password' do
      user.identities << MockIdentity.new
      user.save!
      user.password_identity.should be_nil
    end  
  end
 
end
