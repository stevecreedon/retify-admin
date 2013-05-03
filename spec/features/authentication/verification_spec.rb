require 'spec_helper'

describe 'email verification' do

  context 'nag notification', :js => true do
    it 'should show allow a new user to log in but show a nag screen' do

      user = FactoryGirl.create(:user_with_identity)
      sign_in(user)

      visit root_path

      page.should have_content('Please verify your email address')

    end

    it 'should not show a nag screen to a verified user' do

      user = FactoryGirl.create(:user_with_verified_identity)

      sign_in(user)

      visit root_path

      page.should_not have_content('Please verify your email address')

    end

    it 'resends email' do
      user = FactoryGirl.create(:user_with_identity)
      sign_in(user)

      visit app_path

      page.should have_content('Please verify your email address')

      click_on 'Send again'

      page.should have_content('Verification')

      ActionMailer::Base.deliveries = []

      click_on 'Send email again'

      page.should have_content('Verification email sent')

      ActionMailer::Base.deliveries.should_not be_empty
    end
  end

  context 'verify' do

    it 'should verify the user with the supplied guid' do
      user = FactoryGirl.create(:user_with_identity)

      visit verify_registration_path(user.password_identity.validate_email_token.guid)
      user.reload
      user.password_identity.verified?.should be_true
    end

  end


end


