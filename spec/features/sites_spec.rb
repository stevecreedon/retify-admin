require 'spec_helper'

describe 'Sites', :js => true do
  context 'user not authenticated' do
    it 'redirects to sign_in page' do
      visit sites_path

      page.current_path.should == new_session_path
    end
  end
  context 'user authenticated' do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in(user)
    end

    it 'shows site creation form if there is no sites for this user' do
      within '.main-menu' do
        click_link('Sites')
      end
      page.should have_content('Create your Micro-Hotel website!')
    end

    it 'shows site if there is site created for this user' do
      FactoryGirl.create(:site, :user => user)

      within '.main-menu' do
        click_link('Sites')
      end
      page.should have_content('Your Micro-Hotel website settings')
    end

    it 'adds new site' do
      visit sites_path

      fill_in('Title',        :with => 'Site title' )
      fill_in('Site name',    :with => 'mysite')
      fill_in('Domain name',  :with => 'www.mysite.com')
      fill_in('Phone number', :with => '0987654321')

      click_button('Save changes')

      page.should have_content('Your Micro-Hotel website settings')
      page.should have_content('Site title')
      page.should have_content('mysite')
      page.should have_content('www.mysite.com')
      page.should have_content('0987654321')
      page.should have_content('style_01')
      page.should have_content(user.email)

    end

    it 'edits the site' do
      FactoryGirl.create(:site, :user => user)

      visit sites_path

      click_link('Edit')

      fill_in('Title',        :with => 'Site title changed' )

      click_button('Save changes')

      page.should have_content('Your Micro-Hotel website settings')
      page.should have_content('Site title changed')

    end

    context 'invalid parameters' do
      it 'shows erros if there are' do
        visit sites_path

        click_button('Save changes')

        page.should have_content("Subdomain can't be blank")
        page.should have_content("Phone can't be blank")
      end
    end
  end
end

