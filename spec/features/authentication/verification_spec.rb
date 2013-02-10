require 'spec_helper'

describe 'email verification' do

  context 'nag notification' do
    it 'should show allow a new user to log in but show a nag screen' do

      visit root_path

      click_link("sign up here")

      fill_in(:identity_email, :with => 'test@test.co.ab')
      fill_in(:identity_password, :with => 'abcdefgh')
      click_button('sign up')

      page.current_path.should == dashboard_index_path
      page.should have_content('please verify your email address')

    end

  
    it 'should not show a nag screen to a verified user' do       
      
      user = FactoryGirl.build(:user)
      user.identities.build(:email => 'joe@test.co', :password => 'password', :provider => 'password')
      user.save

      identity = user.identities.rentified.first      
      identity.email_verified = true
      identity.save!

      sign_in(user.identities.first.email, 'password')
      
      visit root_path

      page.current_path.should == dashboard_index_path
      page.should_not have_content('please verify your email address')

    end
  end

  context 'verify' do

    it 'should verify the user with the supplied guid' do
      user = FactoryGirl.create(:user_with_identity)

      visit verify_registration_path(user.guid)
      user.reload
      user.verified?.should be_true
    end

  end


end


