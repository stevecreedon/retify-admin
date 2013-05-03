require 'spec_helper'

describe 'feed for property tems page' do
  context 'user from sign up page', js: true do
    let(:user)     { FactoryGirl.create(:user_with_identity) }
    let(:property) { FactoryGirl.create(:property, user: user) }
    let!(:feed)    { FactoryGirl.create(:feed, feed_type: :create_property_terms_page, user: user, parent_id: property.id) }

    before do
      sign_in(user.password_identity.email)
      visit app_path

      find("a[href='#item-#{feed.id}']").click
    end
   
    it 'creates property temrs page' do
      fill_in('Title',       with: 'Terms and Conditions' )
      fill_in('Description', with: 'Description for terms' )

      click_on('Save')

      page.should_not have_css("a[href='#item-#{feed.id}']")
      page.should have_content("Terms Page was saved")

      property.reload
      article = property.articles.first
      article.should_not be_nil
      article.title.should       == 'Terms and Conditions'
      article.description.should == 'Description for terms'
    end

    context 'invalid parameters' do
      it 'shows erros if there are' do
        click_on('Save')

        within(:css, "field[value='model.title']") do
          page.should have_content("can't be blank")
        end
        within(:css, "field[value='model.description']") do
          page.should have_content("can't be blank")
        end

        page.should have_css("a[href='#item-#{feed.id}']")
      end

    end
  end
end

