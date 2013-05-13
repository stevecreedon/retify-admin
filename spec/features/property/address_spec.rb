require 'spec_helper'

describe 'property page address', js: true do
  let(:user)      { FactoryGirl.create(:user_with_verified_identity) }
  let!(:property) { FactoryGirl.create(:property, user: user) }

  before do
    sign_in(user)
    visit "/app#/properties/#{property.id}"
    page.should have_content(property.title)

    click_on 'Address'
  end

  it 'shows all properties' do
    fill_in "Street",    with: '7 Soho Square'
    fill_in "City",      with: 'London'
    fill_in "Country",   with: 'UK'
    fill_in "Post code", with: 'W1D 3QB'

    page.should have_content('Address found: 7 Soho Square, London, Greater London W1D 3QB, UK')

    click_on 'Save'
   
    page.should have_content('Property address was saved')

    property.reload
    property.address.address.should   == '7 Soho Square'
    property.address.city.should      == 'London'
    property.address.country.should   == 'UK'
    property.address.post_code.should == 'W1D 3QB'
  end

  context 'invalid parameters' do
    it 'shows erros if there are' do
      fill_in "Street",    with: ''
      fill_in "City",      with: ''
      fill_in "Country",   with: ''
      fill_in "Post code", with: ''

      click_on 'Save'

      within(:css, "field[value='property.address.address']") do
        page.should have_content("can't be blank")
      end
      within(:css, "field[value='property.address.city']") do
        page.should have_content("can't be blank")
      end
      within(:css, "field[value='property.address.country']") do
        page.should have_content("can't be blank")
      end
      within(:css, "field[value='property.address.post_code']") do
        page.should have_content("can't be blank")
      end
    end
  end
end

