require 'spec_helper'

describe User do
  
  context 'guid' do

    it 'should create a guid on model creation' do
       identity = Identity.new(:email => 'joe@joe.co', :password => 'passwd', :provider => 'password')
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

  end
