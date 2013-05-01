require 'spec_helper'

describe 'feed for property photos' do
  context 'user from sign up page', js: true do
    let(:user)     { FactoryGirl.create(:user_with_identity) }
    let(:property) { FactoryGirl.create(:property, user: user) }
    let!(:feed)    { FactoryGirl.create(:feed, feed_type: :create_property_photos, user: user, parent_id: property.id) }

    before do
      sign_in(user.password_identity.email)
      visit app_path

      find("a[href='#item-#{feed.id}']").click
    end
   
    it 'creates property photo' do
      page.should have_content('Upload file')

      # capybara can't attach file to not vissible file input field, so lets make it vissible
      page.execute_script("$('span.btn-file').removeClass('btn-file');")

      attach_file('fileupload', "#{Rails.root}/spec/static/property_photo.jpg")

      # the src ends with photo name
      page.should have_selector("img[src$='property_photo.jpg']")

      property.reload
      photo = property.photos.first
      photo.should_not be_nil
      photo.image.to_s.should match(%r{property_photo\.jpg})
    end
  end
end

