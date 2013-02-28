require 'spec_helper'

describe PasswordIdentity do
 
      it 'should send a verification email on creation for a password provider' do
        user = build_user         
        mail_delivery do
          user.save!
        end.should be_true
      end

      context 'password limits' do

       it 'should not be valid if the password is nil' do
        identity = PasswordIdentity.new(:password => nil)
        identity.updating_password = true
        identity.valid?
        identity.errors[:password].should == ["not provided"]
       end

       it 'should not be valid if the password is an empty string' do
        identity = PasswordIdentity.new(:password => '   ')
        identity.updating_password = true
        identity.valid?
        identity.errors[:password].should == ["not provided"]
       end

       it 'should not be valid if the password contains non-alphanumrics' do
        identity = PasswordIdentity.new(:password => 'xzy:123')
        identity.updating_password = true
        identity.valid?
        identity.errors[:password].should include("must contain only characters or numbers")
       end

       it 'should not be valid if the password is less than 6 characters' do
        identity = PasswordIdentity.new(:password => 'xzy1')
        identity.updating_password = true
        identity.valid?
        identity.errors[:password].should include("must be at least 6 characters long")
       end

       it 'should not be valid if the password does not match confirm' do
        identity = PasswordIdentity.new(:password => 'xzy123')
        identity.updating_password = true
        identity.valid?
        identity.errors[:password].should include("and Password Confirmation do not match")
       end
    end
end
