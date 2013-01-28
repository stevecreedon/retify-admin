# coding: utf-8
module MyHelpers
  module AuthenticationHelpers
    def sign_in(email, password = 'pass')
      visit new_session_path

      within '#sign-in' do
        fill_in('Email',    :with => email)
        fill_in('Password', :with => password)

        click_button('sign in')
      end
    end

    def sign_out
      visit destroy_session_path
    end
  end
end

RSpec.configure do |config|
  config.include MyHelpers::AuthenticationHelpers, :type => :feature
end

