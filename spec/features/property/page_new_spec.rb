require 'spec_helper'

describe 'property page new', js: true do
  let(:user)      { FactoryGirl.create(:user_with_verified_identity) }
  let!(:property) { FactoryGirl.create(:property, user: user) }

  before do
    sign_in(user)
    visit "/app#/properties/#{property.id}"
    page.should have_content(property.title)

    click_on 'Add page'
  end

  it 'creates new direction' do
    select  "Availability Page", from: 'Page'
    fill_in "Title",             with: 'new Title'
    fill_in "Description",       with: 'new Description'

    click_on 'Save'
   
    page.should have_content('Page was created')

    within(:css, "ul.nav.nav-list") do
      page.should have_content('new Title')
    end

    property.reload
    article = property.articles.first
    article.should_not be_nil
    article.group.should       == 'availability'
    article.title.should       == 'new Title'
    article.description.should == 'new Description'
  end

  context 'invalid parameters' do
    it 'shows erros if there are' do
      fill_in "Title",             with: ''
      fill_in "Description",       with: ''

      click_on 'Save'

      within(:css, "field[value='page.group']") do
        page.should have_content("can't be blank")
      end
      within(:css, "field[value='page.title']") do
        page.should have_content("can't be blank")
      end
      within(:css, "field[value='page.description']") do
        page.should have_content("can't be blank")
      end
    end
  end
end

