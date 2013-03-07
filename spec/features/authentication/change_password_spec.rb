require 'spec_helper'

describe 'change password' do

  let(:user){FactoryGirl.create(:user_with_identity)}
  let(:identity){ user.password_identity}

  before do
    FactoryGirl.create(:site,     user: user)
    FactoryGirl.create(:property, user: user)
  end

  context 'password identity users' do

    it 'should allow the user to change their password', :js => true do

      sign_in(user.email)
      
      visit dashboard_index_path

      click_link("user-dropdown")

      click_link("Change password")

      fill_in 'identity[password]', with: 'abcxzy'
      fill_in :confirm, with: 'abcxzy'

      click_on 'change my password'

      current_path.should == dashboard_index_path

      page.should have_content('happy days - password changed')    

      sign_out

      sign_in(user.email, 'abcxzy')

      current_path.should == dashboard_index_path

    end

    it 'should return the user to the change password page if the password/confirmation are not valid' do

        sign_in(user.email)
      
        visit edit_password_path

        fill_in 'identity[password]', with: 'abcxzy'
        fill_in :confirm, with: '123789'

        click_on 'change my password'

        current_path.should == edit_password_path
        page.should have_content('Password and Password Confirmation do not match')
     
    end


  end

  context 'non-password user' do
    
    pending 'should not allow a non-password provider to change password'

  end

  context 'request forgotten password' do

    it 'should allow the anonymous user to request and change the password' do

      visit forgot_password_path

      fill_in :email, :with => user.password_identity.email

      mail_delivery do
        click_on 'change my password'
      end.should be_true

      page.current_path.should == sent_password_path
      page.should have_content("has been sent to #{user.password_identity.email}")

      visit edit_password_path(:tid => user.forgot_password_token.guid)
      
      fill_in 'identity[password]', with: 'anewpassword'
      fill_in :confirm, with: 'anewpassword'

      click_on 'change my password' 

      visit new_session_path
   
      fill_in 'sessions[email]', :with => user.password_identity.email
      fill_in 'sessions[password]', :with => 'anewpassword'

      click_on 'Sign in'
   
      current_path.should == dashboard_index_path
      
    end

    it 'should not send email and return the anonymous user to the forgot password page when bad email' do

      visit forgot_password_path

      fill_in :email, :with => "bad@password.co.uk"

      mail_delivery do
        click_on 'change my password'
      end.should_not be_true

      page.current_path.should == forgot_password_path
      page.should have_content("user with email bad@password.co.uk not found")

             
    end

    it 'should return the anonymous user to the password edit page when the password is bad' do

      visit forgot_password_path

      fill_in :email, :with => user.password_identity.email

      mail_delivery do
        click_on 'change my password'
      end.should be_true

      page.current_path.should == sent_password_path
      page.should have_content("has been sent to #{user.password_identity.email}")

      visit edit_password_path(:tid => user.forgot_password_token.guid)
      
      fill_in 'identity[password]', with: 'anewpassword'
      fill_in :confirm, with: 'anewpasswordddd'

      click_on 'change my password' 
     
      current_path.should == edit_password_path
      page.should have_content("Password and Password Confirmation do not match")
              
    end
  end
end
