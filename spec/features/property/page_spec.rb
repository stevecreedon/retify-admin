require 'spec_helper'

describe 'property pages', js: true do
  let(:user)       { FactoryGirl.create(:user_with_identity) }
  let!(:property)  { FactoryGirl.create(:property, user: user) }
  let!(:article)      { FactoryGirl.create(:article, source_id: property.id, source_type: 'property' ) }

  before do
    sign_in(user)
    visit "/app#/properties/#{property.id}"
    page.should have_content(property.title)

    click_on article.title
  end

  it 'saves updated page' do
    fill_in "Title",       with: 'New title'
    fill_in "Description", with: 'New description'

    click_on 'Save'
   
    page.should have_content('Page was saved')

    property.reload
    article = property.articles.first
    article.should_not be_nil
    article.title.should       == 'New title'
    article.description.should == 'New description'
  end

  context 'invalid parameters' do
    it 'shows erros if there are' do
      fill_in "Title",       with: ''
      fill_in "Description", with: ''

      click_on 'Save'

      within(:css, "field[value='page.title']") do
        page.should have_content("can't be blank")
      end
      within(:css, "field[value='page.description']") do
        page.should have_content("can't be blank")
      end
    end
  end
end

