require 'spec_helper'

describe 'properties page' do
  context 'user from sign up page', js: true do
    let(:user)    { FactoryGirl.create(:user_with_verified_identity) }

    before do
      sign_in(user)
      visit app_path
    end

    it 'shows all properties' do
      property1 = FactoryGirl.create(:property, user: user, title: 'Flat',  description: 'Flat description')
      property2 = FactoryGirl.create(:property, user: user, title: 'House', description: 'House description')
     
      click_on('Properties')

      page.should have_content(property1.title)
      page.should have_content(property2.title)

      fill_in('property-search', with: 'Flat')

      page.should have_content(property1.title)
      page.should_not have_content(property2.title)

      fill_in('property-search', with: 'House')

      page.should_not have_content(property1.title)
      page.should have_content(property2.title)

      fill_in('property-search', with: 'Flat desc')

      page.should have_content(property1.title)
      page.should_not have_content(property2.title)

      fill_in('property-search', with: 'House desc')

      page.should_not have_content(property1.title)
      page.should have_content(property2.title)
    end
  end
end

