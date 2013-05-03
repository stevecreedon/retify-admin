require 'spec_helper'

describe 'feed for property calendar' do
  context 'user from sign up page', js: true do
    let(:user)     { FactoryGirl.create(:user_with_verified_identity) }
    let(:property) { FactoryGirl.create(:property, user: user) }
    let!(:feed)    { FactoryGirl.create(:feed, feed_type: :create_property_calendar, user: user, parent_id: property.id) }

    before do
      sign_in(user)
      visit app_path

      find("a[href='#item-#{feed.id}']").click
    end
   
    it 'creates property calendar' do
      fill_in('Provider', with: 'Google' )
      fill_in('Path',     with: 'path/to/calendar' )

      click_on('Save')

      page.should_not have_css("a[href='#item-#{feed.id}']")
      page.should have_content("Calendar was saved")

      property.reload
      calendar = property.calendars.first
      calendar.should_not be_nil
      calendar.provider.should == 'Google'
      calendar.path.should     == 'path/to/calendar'
    end

    context 'invalid parameters' do
      it 'shows erros if there are' do
        click_on('Save')

        within(:css, "field[value='model.path']") do
          page.should have_content("can't be blank")
        end
        within(:css, "field[value='model.provider']") do
          page.should have_content("can't be blank")
        end

        page.should have_css("a[href='#item-#{feed.id}']")
      end

    end
  end
end

