require 'spec_helper'

describe 'Property calendars' do
  let(:user)    { FactoryGirl.create(:user) }
  let(:property)    { FactoryGirl.create(:property, user: user) }

  context 'user not authenticated' do
    it 'redirects to sign_in page' do
      visit property_calendars_path(property)

      page.current_path.should == new_session_path
    end
  end
  context 'user authenticated', :js => true do
    before do
      property # create property
      sign_in(user)
    end

    it 'adds new calendar' do

      within '.main-menu' do
        click_link('Properties')
      end

      within '#dynamic-content' do
        click_link('Calendar')
      end

      page.should have_content('Create your calendar')

      fill_in('Provider', :with => 'google' )
      fill_in('Path',     :with => 'some_path_to_google')

      click_button('Save changes')

      page.should have_content('Your calendar details')
      page.should have_content('google')
      page.should have_content('some_path_to_google')

    end

    it 'edits the calendar' do
      FactoryGirl.create(:calendar, :property => property)

      within '.main-menu' do
        click_link('Properties')
      end

      within '#dynamic-content' do
        click_link('Calendar')
      end

      page.should have_content('Your calendar details')

      click_link('Edit')

      fill_in('Path',        :with => 'some_changed_path' )

      click_button('Save changes')

      page.should have_content('Your calendar details')
      page.should have_content('some_changed_path')

    end

    context 'invalid parameters' do
      it 'shows erros if there are' do

        visit new_property_calendar_path(property)

        click_button('Save changes')

        page.should have_content("Path can't be blank")
        page.should have_content("Provider can't be blank")
      end
    end

  end
end

