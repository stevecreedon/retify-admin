require 'spec_helper'

describe 'sign-up' do
  describe 'from home page' do

    it 'should allow the user to sign up from the home page' do
      visit root_path
      
      fill_in 'password_identity[email]', :with => 'some.email@address.co.uk'
      fill_in 'password_identity[password]', :with => 'abcxyz'

      click_on 'Get started'

      current_path.should == edit_account_path(User.first.id)

      page.should have_content("welcome to loveBnB, we hope you'll come back often")
      
      PasswordIdentity.where(email: 'some.email@address.co.uk', provider: 'password').first.should_not be_nil
    end

    it 'should redirect the user to the sign-up page if the sign-up fails' do
      visit root_path

      fill_in 'password_identity[email]', :with => 'some.email@address.co.uk'
      fill_in 'password_identity[password]', :with => 'abc'

      click_on 'Get started'

      current_path.should == new_registration_path

      page.should have_content('Password must be at least 6 characters long')
    end

    it 'should redirect the user to the sign-in page if the email exists' do
      user = FactoryGirl.create(:user_with_identity)
      identity = user.password_identity

      visit root_path

      fill_in 'password_identity[email]', :with => identity.email

      click_on 'Get started'

      current_path.should == new_session_path

      find_field('sessions[email]').value.should == identity.email

      page.should have_content("you've already signed-up, please login here")
    end
  end

  describe 'from sign up page' do
    it 'should allow the user to sign up' do
      visit new_registration_path

      fill_in 'password_identity[email]', :with => 'some.email@address.co.uk'
      fill_in 'password_identity[password]', :with => 'abcxyz'

      click_on 'Sign up'

      current_path.should == edit_account_path(User.first.id)

      Identity.where(email: 'some.email@address.co.uk', provider: 'password').first.should_not be_nil
   end

   it 'should return the user to the sign up page when something fails' do
     visit new_registration_path

     fill_in 'password_identity[email]', :with => 'some.email@address.co.uk'
     fill_in 'password_identity[password]', :with => nil

     click_on 'Sign up'

     current_path.should == new_registration_path

     find_field('password_identity[email]').value.should == 'some.email@address.co.uk'
   end

   it 'should redirect the user to the sign-in page if the email exists' do
     user = FactoryGirl.create(:user_with_identity)
     identity = user.password_identity


     visit new_registration_path

     fill_in 'password_identity[email]', :with => identity.email

     click_on 'Sign up'

     current_path.should == new_session_path

     find_field('sessions[email]').value.should == identity.email

     page.should have_content("you've already signed-up, please login here")
   end
  end
end

