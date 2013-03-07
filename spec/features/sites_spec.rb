require 'spec_helper'

describe 'Sites' do
  context 'user not authenticated' do
    it 'redirects to sign_in page' do
      visit sites_path

      page.current_path.should == new_session_path
    end
  end
  context 'user authenticated', :js => true do
    let(:user) { FactoryGirl.create(:user_with_identity)}
    before do
      sign_in(user.identities.first.email, 'passwd')
    end

    it 'adds new site' do
      within '.main-menu' do
        click_link('Sites')
      end

      page.should have_content('Create your Micro-Hotel Website')

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
      page.should have_content(user.identities.first.email)

    end

    it 'edits the site' do
      FactoryGirl.create(:site, :user => user)

      within '.main-menu' do
        click_link('Sites')
      end

      page.should have_content('Your Micro-Hotel website settings')

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

