# coding: utf-8
module MyHelpers
  module AuthenticationHelpers
    def sign_in user
      page.set_rack_session(:user_id => user.id)
    end

    def sign_in_with_ui(email, password = 'passwd')
      visit new_session_path

      within '.sign-form' do
        fill_in('Email',    :with => email)
        fill_in('Password', :with => password)

        click_button('Sign in')
      end
    end

    def sign_out
      page.set_rack_session(:user_id => nil)
    end
  end
end

RSpec.configure do |config|
  config.include MyHelpers::AuthenticationHelpers, :type => :feature
end

