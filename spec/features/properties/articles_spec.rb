require 'spec_helper'

describe 'Property articles' do
  let(:user)     { FactoryGirl.create(:user_with_identity) }
  let(:property) { FactoryGirl.create(:property, user: user) }

  context 'user not authenticated' do
    it 'redirects to sign_in page' do
      visit property_articles_path(property)

      page.current_path.should == new_session_path
    end
  end
  context 'user authenticated', :js => true do
    before do
      property # create property
      sign_in(user.identities.first.email, 'pass')
    end

    it 'adds new article' do

      within '.main-menu' do
        click_link('Properties')
      end

      within '#dynamic-content' do
        click_link('Articles')
      end

      page.should have_content('Create your article')

      select('Availabilities', from: 'Group')
      fill_in('Title',         with: 'article title' )
      fill_in('Description',   with: 'article description')

      click_button('Save changes')

      page.should have_content('Article details')
      page.should have_content('Availabilities')
      page.should have_content('article title')
      page.should have_content('article description')

      click_link('Back')

      page.should have_content('Articles')
      page.should have_content('article title')
      page.should have_content('Availabilities')

      page.should_not have_content('article description')
    end

    it 'shows and edits the article' do
      article = FactoryGirl.create(:article, source_id: property.id)

      within '.main-menu' do
        click_link('Properties')
      end

      within '#dynamic-content' do
        click_link('Articles')
      end

      page.should have_content('Articles')

      click_link('Show')

      page.should have_content('Article details')
      page.should have_content(article.decorate.group_name)
      page.should have_content(article.title)
      page.should have_content(article.description)

      click_link('Edit')

      fill_in('Description', :with => 'some updated description' )

      click_button('Save changes')

      page.should have_content('Article details')
      page.should have_content('some updated description')
    end

    it 'edits the article' do
      FactoryGirl.create(:article, source_id: property.id)

      within '.main-menu' do
        click_link('Properties')
      end

      within '#dynamic-content' do
        click_link('Articles')
      end

      page.should have_content('Articles')

      click_link('Edit')

      fill_in('Description', :with => 'some updated description' )

      click_button('Save changes')

      page.should have_content('Article details')
      page.should have_content('some updated description')

    end

    it 'deletes the article' do
      article1 = FactoryGirl.create(:article, source_id: property.id, title: 'Article 1')
      article2 = FactoryGirl.create(:article, source_id: property.id, title: 'Article 2')

      within '.main-menu' do
        click_link('Properties')
      end

      within '#dynamic-content' do
        click_link('Articles')
      end

      page.should have_content('Articles')

      within_table_row 'Article 1' do
        click_link('Delete')
      end

      page.should have_content('Articles')

      page.should_not have_content(article1.title)

      page.should have_content(article2.title)
    end

    context 'invalid parameters' do
      it 'shows erros if there are' do

        visit new_property_article_path(property)

        click_button('Save changes')

        page.should have_content("Title can't be blank")
        page.should have_content("Description can't be blank")
      end
    end

  end
end

