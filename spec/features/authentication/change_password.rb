require 'spec_helper'

describe 'change password' do

  context 'rentified users' do

     let(:user){FactoryGirl.create(:user_with_identity)}
     let(:identity){ user.identities.rentified.first!}

      it 'should allow the user to change their password', :js => true do

        sign_in(user.email)
        
        visit dashboard_index_path

        click_link("user-dropdown")

        click_link("Change password")

        fill_in 'identity[password]', with: 'abcxzy'
        fill_in 'identity[confirm]', with: 'abcxzy'

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
          fill_in 'identity[confirm]', with: '123789'

          click_on 'change my password'

          current_path.should == edit_password_path
          page.should have_content('password and confirm password do not match')
       
      end


    end

    context 'non-password user' do
      
       pending 'should not allow a non-password provider to change password'

    end
   
end
