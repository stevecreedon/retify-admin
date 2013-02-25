require 'spec_helper'

describe Identity do
 
  context 'verification' do
    
    context 'password provider' do

      it 'should send a verification email on creation for a password provider' do
        user = build_user         
        mail_delivery do
          user.save!
        end.should be_true
      end

      context 'password' do

       it 'should not be valid if the password is nil' do
        identity = Identity.new(:password => nil, :provider => 'password')
        identity.valid?
        identity.errors[:password].should == ["no password provided"]
       end

       it 'should not be valid if the password is an empty string' do
        identity = Identity.new(:password => '   ', :provider => 'password')
        identity.valid?
        identity.errors[:password].should == ["no password provided"]
       end

       it 'should not be valid if the password contains non-alphanumrics' do
        identity = Identity.new(:password => 'xzy:123', :provider => 'password')
        identity.valid?
        identity.errors[:password].should include("password must contain only characters or numbers")
       end

       it 'should not be valid if the password is less than 6 characters' do
        identity = Identity.new(:password => 'xzy1', :provider => 'password')
        identity.valid?
        identity.errors[:password].should include("password must be at least 6 characters long")
       end

       it 'should not be valid if the password does not match confirm' do
        identity = Identity.new(:password => 'xzy123', :confirm => '123xyz', :provider => 'password')
        identity.valid?
        identity.errors[:password].should include("password and confirm password do not match")
       end
      
      end

     


    end

    context 'other provider' do
          
      it 'should not send a verification email on creation for a non-password provider' do
        user = build_user(identity: {provider: 'twaddle'})     
      
        mail_delivery do
          user.save!
        end.should_not be_true
      end

      it 'should not verify password for a non-password provider' do
 
        identity = Identity.new(:provider => 'twaddle')
        Identity.private_instance_methods.should include(:validate_password)
        identity.should_receive(:validate_password).never         
        identity.valid?    
      end


    end     
  end 
end
