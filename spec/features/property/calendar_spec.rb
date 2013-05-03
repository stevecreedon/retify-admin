require 'spec_helper'

describe 'property page address', js: true do
  let(:user)      { FactoryGirl.create(:user_with_identity) }
  let!(:property) { FactoryGirl.create(:property, user: user) }
  let!(:calendar) { FactoryGirl.create(:calendar, property: property) }

  before do
    sign_in(user.password_identity.email)
    visit "/app#/properties/#{property.id}"
    page.should have_content(property.title)

    click_on calendar.provider
  end

  it 'saves updated calendar' do
    fill_in "Provider",  with: 'New Provider'
    fill_in "Path",      with: 'New Path to calendar'

    click_on 'Save'
   
    page.should have_content('Calendar was saved')

    within(:css, "ul.nav.nav-list") do
      page.should have_content('New Provider')
    end

    property.reload
    calendar = property.calendars.first
    calendar.should_not be_nil
    calendar.provider.should == 'New Provider'
    calendar.path.should     == 'New Path to calendar'
  end

  context 'invalid parameters' do
    it 'shows erros if there are' do
      fill_in "Provider",  with: ''
      fill_in "Path",      with: ''

      click_on 'Save'

      within(:css, "field[value='calendar.provider']") do
        page.should have_content("can't be blank")
      end
      within(:css, "field[value='calendar.path']") do
        page.should have_content("can't be blank")
      end
    end
  end
end

