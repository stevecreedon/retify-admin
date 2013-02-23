require 'spec_helper'

describe 'sign-up' do

  describe 'from home page' do

   it 'should allow the user to sign up from the home page' do

    visit root_path

    fill_in 'identity[email]', :with => 'some.email@address.co.uk'
    fill_in 'identity[password]', :with => 'abcxyz'

    click_on 'Create your account'

    current_path.should == dashboard_index_path

    Identity.where(email: 'some.email@address.co.uk', provider: 'password').first.should_not be_nil
 
   end

   it 'should redirect the user to the sign-up page if the sign-up fails' do

    visit root_path

    fill_in 'identity[email]', :with => 'some.email@address.co.uk'

    click_on 'Create your account'

    current_path.should == new_registration_path

    page.should have_content('sign up failed')

   end

   it 'should redirect the user to the sign-in page if the email exists' do

    user = FactoryGirl.create(:user_with_identity)
    identity = user.identities.rentified.first!


    visit root_path

    fill_in 'identity[email]', :with => identity.email

    click_on 'Create your account'

    current_path.should == new_session_path

    find_field('sessions[email]').value.should == identity.email

    page.should have_content("#{identity.email} exists")

   end


  end

  describe 'from sign up page' do

    it 'should allow the user to sign up' do
     visit new_registration_path

     fill_in 'identity[email]', :with => 'some.email@address.co.uk'
     fill_in 'identity[password]', :with => 'abcxyz'

     click_on 'Sign up'

     current_path.should == dashboard_index_path
 
     Identity.where(email: 'some.email@address.co.uk', provider: 'password').first.should_not be_nil
   end

   it 'should return the user to the sign up page when something fails' do
     visit new_registration_path

     fill_in 'identity[email]', :with => 'some.email@address.co.uk'
     fill_in 'identity[password]', :with => nil

     click_on 'Sign up'

     current_path.should == new_registration_path

     find_field('identity[email]').value.should == 'some.email@address.co.uk'
 
   end


   it 'should redirect the user to the sign-in page if the email exists' do

    user = FactoryGirl.create(:user_with_identity)
    identity = user.identities.rentified.first!


    visit new_registration_path

    fill_in 'identity[email]', :with => identity.email

    click_on 'Sign up'

    current_path.should == new_session_path

    find_field('sessions[email]').value.should == identity.email

    page.should have_content("#{identity.email} exists")

   end


  

  end

end

