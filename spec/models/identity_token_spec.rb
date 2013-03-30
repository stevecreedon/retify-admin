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
       token.valid_until.should == Time.gm(*Time.now) + 24.hours 
     end
    end

    it 'should return a token when the guid matches and valid_until has not been exceeded' do
       token = Tokens::ForgotPassword.create!
       
       Timecop.travel(Time.gm(*Time.now) + 23.hours) do
         Tokens::ForgotPassword.valid(token.guid).first.should == token  
       end
    end

    it 'should not return a token when the guid matches but valid_until has been exceeded' do
       token = Tokens::ForgotPassword.create!
       
       Timecop.travel(Time.gm(*Time.now) + 25.hours) do
         Tokens::ForgotPassword.valid(token.guid).first.should be_nil 
       end
    end



  end
end
