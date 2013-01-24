require 'spec_helper'

describe 'Dashboard' do
  context 'without authentication' do
    it 'redirects to sign_in page' do
      visit dashboard_index_path

      page.current_path.should == new_session_path
    end 
  end
 
  context 'with authentication', :js => true do
    it 'shows the dashboard content' do
      user = User.create(provider: 'password', email: 'test@domain.com', password: 'pass')

      sign_in(user)

      visit dashboard_index_path

      page.should have_content('Home /  Dashboard')
    end
  end
end

