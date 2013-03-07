require 'spec_helper'

describe 'Tutorial' do
  context 'without authentication' do
    it 'redirects to sign_in page' do
      visit tutorial_index_path

      page.current_path.should == new_session_path
    end 
  end
 
  context 'with authentication' do
    let(:user)    { FactoryGirl.create(:user_with_identity) }
    before do
      sign_in(user.identities.first.email, 'passwd')
    end

    it 'shows the site tutorial content' do
      visit tutorial_index_path

      page.current_path.should == tutorial_index_path

      page.should have_content('Welcome to loveBNB! There are N steps to complete before you launch')
      page.should have_content('Add your Site details')
    end

    it 'shows the property tutorial content' do
      FactoryGirl.create(:site,     user: user)

      visit tutorial_index_path

      page.current_path.should == tutorial_index_path

      page.should have_content('Welcome to loveBNB! There are N steps to complete before you launch')
      page.should have_content('Add your Property details')
    end

    context 'with site and property' do
      it 'redirects to dashboard' do
        FactoryGirl.create(:site,     user: user)
        FactoryGirl.create(:property, user: user)

        visit tutorial_index_path

        page.current_path.should == dashboard_index_path
      end
    end

  end
end

