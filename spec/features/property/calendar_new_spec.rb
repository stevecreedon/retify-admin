require 'spec_helper'

describe 'property page address', js: true do
  let(:user)      { FactoryGirl.create(:user_with_verified_identity) }
  let!(:property) { FactoryGirl.create(:property, user: user) }

  before do
    sign_in(user)
    visit "/app#/properties/#{property.id}"
    page.should have_content(property.title)

    click_on 'Add calendar'
  end

  it 'saves updated calendar' do
    fill_in "Provider",  with: 'Provider'
    fill_in "Path",      with: 'Path to calendar'

    click_on 'Save'
   
    page.should have_content('Calendar was created')

    within(:css, "ul.nav.nav-list") do
      page.should have_content('Provider')
    end

    property.reload
    calendar = property.calendars.first
    calendar.should_not be_nil
    calendar.provider.should == 'Provider'
    calendar.path.should     == 'Path to calendar'
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

