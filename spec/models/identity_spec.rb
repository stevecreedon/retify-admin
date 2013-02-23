require 'spec_helper'

describe Identity do
 
  context 'verification' do
    let(:user){FactoryGirl.build(:user)}
    
    context 'password provider' do

      let(:identity){Identity.new(:provider => 'password', :email => 'xyz@xyz.com', :password => "pass")}
   
      it 'should send a verification email on creation for a password provider' do
        user.identities << identity      
      
        mail_delivery do
          user.save!
        end.should be_true
      end

    end

    context 'other provider' do
     
      let(:identity){Identity.new(:provider => 'twaddle', :email => 'xyz@xyz.com', :password => "pass")}
     
      it 'should not send a verification email on creation for a non-password provider' do
        user.identities << identity      
      
        mail_delivery do
          user.save!
        end.should_not be_true
      end

    end     
  end 
end
