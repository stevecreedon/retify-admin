require 'spec_helper'

describe 'Properties' do
  context 'user not authenticated' do
    it 'redirects to sign_in page' do
      visit properties_path

      page.current_path.should == new_session_path
    end
  end
  context 'user authenticated', :js => true do
    let(:user)    { FactoryGirl.create(:user_with_identity) }
    let(:address) { FactoryGirl.create(:address) }
    before do
      sign_in(user.identities.first.email, 'passwd')
    end

    it 'adds new property' do
      within '.main-menu' do
        click_link('Properties')
      end

      page.should have_content('Create your property')
      
      fill_in('Title',                     :with => 'Property title' )
      fill_in('Description',               :with => 'Property description')
      fill_in('property_address_address',                   :with => '1 Line of Address')
      fill_in('property_address_address2', :with => '2 Line of Address')
      fill_in('City',                      :with => 'Property City')
      fill_in('State',                     :with => 'Property State')
      fill_in('Country',                   :with => 'Property Country')
      fill_in('Post code',                 :with => 'Property Post Code')

      click_button('Save changes')

      page.should have_content('Property title')
      page.should have_content('Property description')
      page.should have_content('1 Line of Address')
      page.should have_content('2 Line of Address')
      page.should have_content('Property City')
      page.should have_content('Property State')
      page.should have_content('Property Country')
      page.should have_content('Property Post Code')

    end

    it 'edits the property' do
      FactoryGirl.create(:property, :user => user)

      within '.main-menu' do
        click_link('Properties')
      end

      click_link('Edit')

      fill_in('Title',        :with => 'Property title changed' )

      click_button('Save changes')

      page.should have_content('Property title changed')

    end

    context 'invalid parameters' do
      it 'shows erros if there are' do
        visit properties_path

        click_button('Save changes')

        page.should have_content("Title can't be blank")
        page.should have_content("Address can't be blank")
      end
    end

  end
end

