require 'spec_helper'

describe 'Property photos' do
  let(:user)     { FactoryGirl.create(:user_with_identity) }
  let(:property)    { FactoryGirl.create(:property, user: user) }

  context 'user not authenticated' do
    it 'redirects to sign_in page' do
      visit property_photos_path(property)

      page.current_path.should == new_session_path
    end
  end
  context 'user authenticated', :js => true do
    before do
      property # create property
      sign_in(user.identities.first.email, 'passwd')
    end

    it 'adds new photo' do

      within '.main-menu' do
        click_link('Properties')
      end

      within '#dynamic-content' do
        click_link('Photos')
      end

      attach_file('fileupload', "#{Rails.root}/spec/static/property_photo.jpg")

      page.should have_selector('.masonry-thumb', visible: true)

    end

    it 'removes the photo' do
      FactoryGirl.create(:calendar, :property => property)
      photo = PropertyPhoto.new
      photo.image = File.open("#{Rails.root}/spec/static/property_photo.jpg")
      photo.property = property
      photo.save

      within '.main-menu' do
        click_link('Properties')
      end

      within '#dynamic-content' do
        click_link('Photos')
      end

      page.should have_selector('.masonry-thumb', visible: true)

      find('.masonry-thumb a').click

      page.should have_link('Destroy', visible: true)

      within '#dynamic-content' do
        click_link('Destroy')
      end

      page.should have_selector('#fileupload', visible: true)
      page.should_not have_selector('.masonry-thumb')

      property.photos.count.should == 0
    end

  end
end

