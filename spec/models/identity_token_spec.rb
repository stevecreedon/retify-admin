require 'spec_helper'

describe Tokens do

  context 'validate email token' do
    
    it 'should not set valid_until if the purpose is validate email' do
     token = Tokens::ValidateEmail.create!
     token.valid_until.should == nil
    end

    it 'should generate a guid on creation' do
     token = Tokens::ValidateEmail.create!
     token.guid.should_not be_nil
    end

  end

  context 'forgot password token' do

    it 'should set the valid_until date 24 hours from creation when the purpose is change password' do
     Timecop.freeze do
       token = Tokens::ForgotPassword.create!
       token.valid_until.should == Time.now + 24.hours
     end
    end


  end
end
