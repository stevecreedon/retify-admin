require 'spec_helper'

describe 'email verification' do

  context 'nag notification' do
    it 'should show allow a new user to log in but show a nag screen' do

      user = FactoryGirl.create(:user_with_identity)
      sign_in(user.password_identity.email)

      visit app_path

      page.should have_content('please verify your email address')

    end

    it 'should not show a nag screen to a verified user' do

      user = FactoryGirl.create(:user_with_identity)

      identity = user.password_identity
      identity.verify!
      identity.save!

      sign_in(identity.email, 'passwd')

      visit root_path

      page.should_not have_content('please verify your email address')

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


