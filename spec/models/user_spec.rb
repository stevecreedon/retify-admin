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


  context 'identity tokens' do

    let(:user){FactoryGirl.create(:user_with_identity)}
    
    it 'should delete any existing email identity tokens' do
        token1 = user.create_validate_email_token
        token2 = user.create_validate_email_token
        user.validate_email_token.should == token2
        token1.destroyed?.should be_true
    end

  end

end
