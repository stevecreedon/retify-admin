require 'spec_helper'

describe 'feed for property directions' do
  context 'user from sign up page', js: true do
    let(:user)     { FactoryGirl.create(:user_with_identity) }
    let(:property) { FactoryGirl.create(:property, user: user) }
    let!(:feed)    { FactoryGirl.create(:feed, feed_type: :create_property_directions, user: user, parent_id: property.id) }

    before do
      sign_in(user.password_identity.email)
      visit app_path

      find("a[href='#item-#{feed.id}']").click
    end
   
    it 'creates property calendar' do
      fill_in('By bus', with: 'description for by bus' )
      fill_in('By car', with: 'description for by car' )

      click_on('Save')

      page.should_not have_css("a[href='#item-#{feed.id}']")

      property.reload
      property.directions.size.should == 2
    end

  end
end

