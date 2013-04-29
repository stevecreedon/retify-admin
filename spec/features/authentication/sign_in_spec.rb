require 'spec_helper'

describe 'sign-in' do

  let(:user){FactoryGirl.create(:user_with_identity)}
  let(:identity){ user.password_identity}

  before do
    FactoryGirl.create(:site,     user: user)
    FactoryGirl.create(:property, user: user)
  end
  describe 'existing user trying to sign-in from home page' do

     it 'should redirect an existing user to the sign-in page where they try and sign-up by mistake' do

       visit root_path
       
       fill_in 'password_identity[email]', :with => identity.email
           
       click_on 'Get started'

       current_path.should == new_session_path

       page.should have_content("you've already signed-up, please login here")

     end

     it 'should, on redirect, include the existing users email so that they only repeat the password' do

       visit root_path
       
       fill_in 'password_identity[email]', :with => identity.email
       fill_in 'password_identity[password]', :with => 'does not matter'
     
       click_on 'Get started'

       current_path.should == new_session_path

       find_field('sessions[email]').value.should == identity.email
       fill_in 'sessions[password]', :with => 'passwd'

       click_on 'Sign in'

       current_path.should == app_path

     end 
  end

  describe 'existing user sign in through the login page' do

    it 'should redirect a correct sign-in to the app page' do

     visit new_session_path
     
     fill_in 'sessions[email]', :with => identity.email
     fill_in 'sessions[password]', :with => 'passwd'
  
     click_on 'Sign in'
     
     current_path.should == app_path

     page.should have_content("Happy days - you've come back")

    end

    it 'should return a bad sign-in back to the sign-in page' do

      visit new_session_path
     
      fill_in 'sessions[email]', :with => 'bad-email'
      fill_in 'sessions[password]', :with => 'bad-pass'
  
      click_on 'Sign in'
     
      current_path.should == new_session_path

      page.should have_content("Sorry, sign-in failed for this username & password")
           
    end

  end
end
