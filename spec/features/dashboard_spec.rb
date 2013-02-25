require 'spec_helper'

describe 'Dashboard' do
  context 'without authentication' do
    it 'redirects to sign_in page' do
      visit dashboard_index_path

      page.current_path.should == new_session_path
    end 
  end
 
  context 'with authentication', :js => true do
    let(:user)    { FactoryGirl.create(:user_with_identity) }

    it 'shows the dashboard content' do
      sign_in(user.identities.first.email, 'passwd')

      visit dashboard_index_path

      page.should have_content('Home /  Dashboard')
    end
  end
end

