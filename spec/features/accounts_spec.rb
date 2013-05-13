require 'spec_helper'

describe 'accounts' do
  context 'without authentication' do
    it 'redirects to sign_in page' do
      visit edit_account_path(1)

      page.current_path.should == new_session_path
    end 
  end
 
  context 'with authentication' do
    context 'user from sign up page' do
      let(:user)    { FactoryGirl.create(:user_with_verified_identity, address: nil, phone: nil) }
      before do
        sign_in(user)
      end
      it 'redirects from any page to account creation page' do
        visit app_path

        page.current_path.should == edit_account_path(user.id)
      end

      it 'adds to user the account details' do
        visit edit_account_path(user.id)

        page.should have_content('Some final details before your account is set up')

        fill_in('Name',      :with => 'First Last' )
        fill_in('Street',    :with => '11. Street')
        fill_in('City',      :with => 'London')
        fill_in('Country',   :with => 'UK')
        fill_in('Post code', :with => 'SW1234')
        fill_in('Phone',     :with => '0987654321')

        click_button('I\'m done')

        page.current_path.should == app_path

        user.reload
        user.phone.should      == '0987654321'
        user.address.address   == '11. Street'
        user.address.city      == 'London'
        user.address.country   == 'UK'
        user.address.post_code == 'SW1234'
      end

      context 'invalid parameters' do
        it 'shows erros if there are' do
          visit edit_account_path(user.id)

          click_button('I\'m done')

          page.should have_content("Phone can't be blank")
          page.should have_content("Address can't be blank")
        end
      end
    end
    
  end
end

