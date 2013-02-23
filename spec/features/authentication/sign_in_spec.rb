require 'spec_helper'

describe 'home page' do

  let(:user){FactoryGirl.create(:user_with_identity)}
  let(:identity){ user.identities.rentified.first!}

  describe 'existing user trying to sign-in from home page' do

     it 'should redirect an existing user to the sign-in page where they try and sign-up by mistake' do

       visit root_path
       
       fill_in 'identity[email]', :with => identity.email
           
       click_on 'Create your account'

       current_path.should == new_session_path

     end

     it 'should, on redirect, include the existing users email so that they only repeat the password' do

       visit root_path
       
       fill_in 'identity[email]', :with => identity.email
       fill_in 'identity[password]', :with => 'does not matter'
     
       click_on 'Create your account'

       current_path.should == new_session_path

       find_field('sessions[email]').value.should == identity.email
       fill_in 'sessions[password]', :with => 'pass'

       click_on 'Sign in'

       current_path.should == dashboard_index_path

     end 
  end

  describe 'existing user sign in through the login page' do

    it 'should redirect a correct sign-in to the dashboard page' do

     visit new_session_path
     
     fill_in 'sessions[email]', :with => identity.email
     fill_in 'sessions[password]', :with => 'pass'
  
     click_on 'Sign in'
     
     current_path.should == dashboard_index_path

    end

    it 'should return a bad sign-in back to the sign-in page' do

      visit new_session_path
     
      fill_in 'sessions[email]', :with => 'bad-email'
      fill_in 'sessions[password]', :with => 'bad-pass'
  
      click_on 'Sign in'
     
      current_path.should == new_session_path
           
    end

  end
end
