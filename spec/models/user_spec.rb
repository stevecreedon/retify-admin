require 'spec_helper'

describe User do
  
  context 'password identity' do

    let(:user){FactoryGirl.build(:user)}
   
    it 'should add the identity based on the provider' do
      user.add_identity_from_auth(:provider => 'password', :uid => "12345678", :info => {:email => 'abc@123.zz', :name => "blahh"})
      user.password_identity.should_not be_nil
      user.password_identity.password_digest.should == "12345678"
    end  
  end
 
end
