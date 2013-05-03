require 'spec_helper'

describe 'property page', js: true do
  let(:user)      { FactoryGirl.create(:user_with_verified_identity) }
  let!(:property) { FactoryGirl.create(:property, user: user) }

  before do
    sign_in(user)
    visit "/app#/properties/#{property.id}"
    page.should have_content(property.title)

    click_on 'Description'
  end

  it 'shows all properties' do
    fill_in "Description", with: 'New property description'

    click_on 'Save'
   
    page.should have_content('Property description was saved')

    property.reload
    property.description.should == 'New property description'
  end

  context 'invalid parameters' do
    it 'shows erros if there are' do
      fill_in "Description", with: ''

      click_on 'Save'

      within(:css, "field[value='property.description']") do
        page.should have_content("can't be blank")
      end
    end
  end
end

