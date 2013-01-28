require 'spec_helper'

describe 'Property directions' do
  let(:user)    { FactoryGirl.create(:user) }
  let(:property)    { FactoryGirl.create(:property, user: user) }

  context 'user not authenticated' do
    it 'redirects to sign_in page' do
      visit property_directions_path(property)

      page.current_path.should == new_session_path
    end
  end
  context 'user authenticated', :js => true do
    before do
      property # create property
      sign_in(user)
    end

    it 'adds new directions' do

      within '.main-menu' do
        click_link('Properties')
      end

      within '#dynamic-content' do
        click_link('Directions')
      end

      page.should have_content('Edit your directions data')

      fill_in('by_foot',  :with => 'go by foot' )
      fill_in('by_car',   :with => 'go by car')
      fill_in('by_plane', :with => 'go by plane')

      click_button('Save changes')

      page.should have_content('Your directions data')
      page.should have_content('go by foot')
      page.should have_content('go by car')
      page.should have_content('go by plane')

      page.should_not have_content('By bus')
      page.should_not have_content('By train')

    end

    it 'edits the directions' do
      FactoryGirl.create(:direction, title: 'By foot', description: 'go by foot',  property: property)
      FactoryGirl.create(:direction, title: 'By car', description: 'go by car',  property: property)
      FactoryGirl.create(:direction, title: 'By plane', description: 'go by plane',  property: property)

      within '.main-menu' do
        click_link('Properties')
      end

      within '#dynamic-content' do
        click_link('Directions')
      end

      page.should have_content('Your directions data')

      click_link('Edit')

      fill_in('by_foot',  :with => 'go by foot updated')
      fill_in('by_car',   :with => '')
      fill_in('by_train', :with => 'go by train')

      click_button('Save changes')

      page.should have_content('Your directions data')
      page.should have_content('go by foot updated')
      page.should have_content('go by plane')
      page.should have_content('go by train')

      page.should_not have_content('By bus')
      page.should_not have_content('go by car')

    end

  end
end

