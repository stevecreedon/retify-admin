require 'spec_helper'

describe 'email verification' do

  context 'nag notification' do
    it 'should show allow a new user to log in but show a nag screen' do

      user = FactoryGirl.create(:user_with_identity)
      sign_in(user.identities.rentified.first.email)

      visit dashboard_index_path

      page.should have_content('please verify your email address')

    end

    it 'should not show a nag screen to a verified user' do

      user = FactoryGirl.create(:user_with_identity)

      identity = user.identities.rentified.first
      identity.verify!
      identity.save!

      sign_in(identity.email, 'passwd')

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
      user.identities.rentified.first.verified?.should be_true
    end

  end


end


