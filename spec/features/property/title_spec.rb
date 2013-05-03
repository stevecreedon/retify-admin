require 'spec_helper'

describe 'property page', js: true do
  let(:user)      { FactoryGirl.create(:user_with_identity) }
  let!(:property) { FactoryGirl.create(:property, user: user) }

  before do
    sign_in(user)
    visit "/app#/properties/#{property.id}"
    page.should have_content(property.title)

    click_on 'Title'
  end

  it 'shows all properties' do
    fill_in "Title", with: 'New property title'

    click_on 'Save'
   
    page.should have_content('Property title was saved')

    within :css, "h4" do
      page.should have_content('New property title')
    end
  end

  context 'invalid parameters' do
    it 'shows erros if there are' do
      fill_in "Title", with: ''

      click_on 'Save'

      within(:css, "field[value='property.title']") do
        page.should have_content("can't be blank")
      end
    end
  end
end

