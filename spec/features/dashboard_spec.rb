require 'spec_helper'

describe 'Dashboard' do
  context 'without authentication' do
    it 'redirects to sign_in page' do
      visit dashboard_index_path

      page.current_path.should == new_session_path
    end 
  end
 
  context 'with authentication' do
    let(:user)    { FactoryGirl.create(:user_with_identity) }
    before do
      sign_in(user.identities.first.email, 'passwd')
    end

    it 'shows the dashboard content' do
      FactoryGirl.create(:site,     user: user)
      FactoryGirl.create(:property, user: user)

      visit dashboard_index_path

      page.should have_content('Home /  Dashboard')
    end
  end
end

