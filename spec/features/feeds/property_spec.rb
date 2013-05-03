require 'spec_helper'

describe 'feed for property' do
  context 'user from sign up page', js: true do
    let(:user)    { FactoryGirl.create(:user_with_identity) }
    let!(:feed)   { FactoryGirl.create(:feed, feed_type: :create_property, user: user) }

    before do
      sign_in(user.password_identity.email)
      visit app_path

      find("a[href='#item-#{feed.id}']").click
    end
   
    it 'creates site' do
      fill_in('Title',       with: 'Property Title' )
      fill_in('Description', with: 'Property Description' )

      click_on('Save')

      page.should_not have_css("a[href='#item-#{feed.id}']")
      page.should have_content("Property was saved")
      page.should have_content("Add Calendar to the property")
      page.should have_content("Add Photo to the property")
      page.should have_content("Add Direction to the property")
      page.should have_content("Add Terms and Conditions")
      page.should have_content("Add Availability data")

      user.reload
      property = user.properties.first
      property.should_not be_nil
      property.title.should       == 'Property Title'
      property.description.should == 'Property Description'
    end

    context 'invalid parameters' do
      it 'shows erros if there are' do
        fill_in('Title',          with: nil )
        fill_in('Description',    with: nil )
        fill_in('Street',         with: nil )
        fill_in('City',           with: nil )
        fill_in('Country',        with: nil )
        fill_in('Post code',      with: nil )

        click_on('Save')

        within(:css, "field[value='model.title']") do
          page.should have_content("can't be blank")
        end
        within(:css, "field[value='model.description']") do
          page.should have_content("can't be blank")
        end
        within(:css, "field[value='model.address.address']") do
          page.should have_content("can't be blank")
        end
        within(:css, "field[value='model.address.city']") do
          page.should have_content("can't be blank")
        end
        within(:css, "field[value='model.address.country']") do
          page.should have_content("can't be blank")
        end
        within(:css, "field[value='model.address.post_code']") do
          page.should have_content("can't be blank")
        end

        page.should have_css("a[href='#item-#{feed.id}']")
      end

    end
  end
end

