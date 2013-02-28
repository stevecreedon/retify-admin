require 'spec_helper'

describe Identity do
 
  context 'other provider' do
              
    it 'should not send a verification email on creation for a non-password provider' do
      user = FactoryGirl.build(:user)
      identity = MockIdentity.new
      user.identities << identity   

      mail_delivery do
        user.save!
      end.should_not be_true
    end
  end   
end 
