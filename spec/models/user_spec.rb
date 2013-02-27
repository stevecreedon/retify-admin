require 'spec_helper'

describe User do
  
  context 'rentified?' do

    let(:user){FactoryGirl.create(:user_with_identity)}

    it 'should be true if the user has a rentified identity' do
      user.rentified?.should be_true
    end

    it 'should not be true if the identity is not password' do
      user.identities.first.provider = 'twaddle'
      user.identities.first.save!
      user.rentified?.should be_false
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
