require 'spec_helper'

describe 'property page', js: true do
  let(:user)            { FactoryGirl.create(:user_with_verified_identity) }
  let!(:property)       { FactoryGirl.create(:property, user: user) }
  let!(:property_photo) { FactoryGirl.create(:property_photo, property: property) }

  before do
    sign_in(user)
    visit "/app#/properties/#{property.id}"
    page.should have_content(property.title)

    click_on 'Photos'
  end

  it 'uploads photo' do
    page.should have_content('Upload photo')
    page.should have_selector("img[src$='property_photo.jpg']")

    # capybara can't attach file to not vissible file input field, so lets make it vissible
    page.execute_script("$('span.btn-file').removeClass('btn-file');")

    attach_file('fileupload', "#{Rails.root}/spec/static/property_photo2.jpg")

    page.should have_content('Photo was saved')

    # the src ends with photo name
    page.should have_selector("img[src$='property_photo2.jpg']")

    property.reload
    photo = property.photos.last
    photo.should_not be_nil
    photo.image.to_s.should match(%r{property_photo2\.jpg})
  end

  it 'removes photo' do

    # the src ends with photo name
    page.should have_selector("img[src$='property_photo.jpg']")

    click_on 'Delete'

    page.should_not have_selector("img[src$='property_photo.jpg']")

    property.reload
    photo = property.photos.first
    photo.should be_nil
  end

  it 'shows photo' do
    page.should_not have_selector("div[ng-show='large_photo'] img[src$='property_photo.jpg']")

    click_on 'Show'

    page.should have_selector("div[ng-show='large_photo'] img[src$='property_photo.jpg']")

    click_on 'Hide'

    page.should_not have_selector("div[ng-show='large_photo'] img[src$='property_photo.jpg']")
  end

end

