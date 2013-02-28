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

    it 'should create a validate email identity token' do
	user.email_validation_token!.should == user.identity_tokens.last	
    end

    it 'should delete any existing email identity tokens' do
        token1 = user.email_validation_token!
        token2 = user.email_validation_token!
        user.identity_tokens.count.should == 1
        user.identity_tokens.first.should == token2
    end

    it 'should return the existing email verification identity token.' do
       token = user.email_validation_token!
       user.email_validation_token.should == token
    end 

  end

  end
