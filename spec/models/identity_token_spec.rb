require 'spec_helper'

describe IdentityToken do

  it 'should be only allow a valid purpose' do
     token = IdentityToken.new(:purpose => 'xyz')
     token.valid?
     token.errors[:purpose].should include("is not included in the list")
  end

  it 'should set the valid_until date 24 hours from creation when the purpose is change password' do
     Timecop.freeze do
       token = IdentityToken.create!(:purpose => 'reset_password')
       token.valid_until.should == Time.now + 24.hours
     end
  end

  it 'should not set valid_until if the purpose is validate email' do
     token = IdentityToken.create!(:purpose => 'validate_email')
     token.valid_until.should == nil
  end

  it 'should generate a guid on creation' do
     token = IdentityToken.create!(:purpose => 'validate_email')
     token.guid.should_not be_nil
  end

end
