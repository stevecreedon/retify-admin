require 'spec_helper'

describe User do

  context '#verfied?' do

    it 'should return false if there is a password identity that hasnt been verified' do
      user = FactoryGirl.create(:user_with_identity)
      user.verified?.should be_false
    end


    it 'should return true if there is a password identity that has been verified' do
      user = FactoryGirl.build(:user)
      user.identities.build(:email => 'joe@joe.co', :password => 'xyz123', :provider => 'password')
      user.save!
      identity = user.identities.rentified.first      
      identity.email_verified = true
      identity.save!
      user.verified?.should be_true
    end

    it 'should return true if there is a non-password identity' do
      user = FactoryGirl.build(:user)
      user.identities.build(:email => 'joe@joe.co', :password => 'xyz123', :provider => 'xyz')
      user.save!
      user.verified?.should be_true
    end   

  end

  context 'guid' do

    it 'should create a guid on model creation' do
       identity = Identity.new(:email => 'joe@joe.co', :password => 'dsfdsdfs', :provider => 'password')
       user = User.new
       user.identities << identity
       user.save!
       user.guid.should_not be_nil
    end

    it 'should not update the guid whne the user is subsequently saved' do
      user =  FactoryGirl.create(:user_with_identity)
      guid = user.guid
      user.save!
      user.guid.should == guid
    end

  end

end
