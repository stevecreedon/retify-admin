require 'spec_helper'

describe 'accounts' do
  context 'user from sign up page', js: true do
    let(:user)    { FactoryGirl.create(:user_with_verified_identity, name: nil, phone: nil) }

    before do
      sign_in(user)
    end

    it 'redirects from any page to account creation page' do
      visit app_path

      page.should have_content('Some final details before your account is set up')

      uri = URI.parse(page.current_url)
      "#{uri.path}##{uri.fragment}".should == '/app#/account'
    end

    it 'adds to user the account details' do
      visit app_path

      page.should have_content('Some final details before your account is set up')

      fill_in('Name',      :with => 'First Last' )
      fill_in('Phone',     :with => '0987654321')

      click_on('I\'m done')

      page.should have_content('Account was successfully created.')

      uri = URI.parse(page.current_url)
      "#{uri.path}##{uri.fragment}".should == '/app#/feeds'

      user.reload
      user.phone.should == '0987654321'
      user.name.should  == 'First Last'
    end

    context 'invalid parameters' do
      it 'shows erros if there are' do
        visit app_path

        page.should have_content('Some final details before your account is set up')

        click_on('I\'m done')

        within(:css, "field[value='user.phone']") do
          page.should have_content("can't be blank")
        end
        within(:css, "field[value='user.name']") do
          page.should have_content("can't be blank")
        end
      end
    end
  end
end

