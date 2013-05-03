require 'spec_helper'

describe 'property page address', js: true do
  let(:user)       { FactoryGirl.create(:user_with_identity) }
  let!(:property)  { FactoryGirl.create(:property, user: user) }
  let!(:direction) { FactoryGirl.create(:direction, property: property) }

  before do
    sign_in(user.password_identity.email)
    visit "/app#/properties/#{property.id}"
    page.should have_content(property.title)

    click_on direction.title
  end

  it 'saves updated calendar' do
    fill_in direction.title, with: 'New description'

    click_on 'Save'
   
    page.should have_content('Direction was saved')

    property.reload
    direction = property.directions.first
    direction.should_not be_nil
    direction.description.should == 'New description'
  end

  context 'invalid parameters' do
    it 'shows erros if there are' do
      fill_in direction.title,  with: ''

      click_on 'Save'

      within(:css, "field[value='direction.description']") do
        page.should have_content("can't be blank")
      end
    end
  end
end

