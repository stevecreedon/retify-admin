require 'spec_helper'

describe 'property page address', js: true do
  let(:user)      { FactoryGirl.create(:user_with_identity) }
  let!(:property) { FactoryGirl.create(:property, user: user) }

  before do
    sign_in(user)
    visit "/app#/properties/#{property.id}"
    page.should have_content(property.title)

    click_on 'Add direction'
  end

  it 'creates new direction' do
    select  "By bus",      from: 'Title'
    fill_in "Description", with: 'Description'

    click_on 'Save'
   
    page.should have_content('Direction was created')

    within(:css, "ul.nav.nav-list") do
      page.should have_content('By bus')
    end

    property.reload
    direction = property.directions.first
    direction.should_not be_nil
    direction.title.should       == 'By bus'
    direction.description.should == 'Description'
  end

  context 'invalid parameters' do
    it 'shows erros if there are' do
      fill_in "Description",      with: ''

      click_on 'Save'

      within(:css, "field[value='direction.title']") do
        page.should have_content("can't be blank")
      end
      within(:css, "field[value='direction.description']") do
        page.should have_content("can't be blank")
      end
    end
  end
end

