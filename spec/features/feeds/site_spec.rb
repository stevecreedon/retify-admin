require 'spec_helper'

describe 'feed for site' do
  context 'user from sign up page', js: true do
    let(:user)    { FactoryGirl.create(:user_with_verified_identity) }
    let!(:feed)   { FactoryGirl.create(:feed, feed_type: :create_site, user: user) }

    before do
      sign_in(user)
      visit app_path

      find("a[href='#item-#{feed.id}']").click
    end

    it 'creates site' do
      fill_in('Website domain', with: 'wdomain' )

      fill_in('Street',           with: '55 Oxford street' )
      fill_in('City',             with: 'London' )
      fill_in('Country',          with: 'UK' )
      fill_in('Post code',        with: 'W1D 2EQ' )

      page.should have_content('Address found: 55 Oxford Street')

      click_on('Save')

      page.should_not have_css("a[href='#item-#{feed.id}']")
      page.should have_content("Site was saved")
      page.should have_content('wdomain.lovebnb.com')

      user.reload
      site = user.sites.first
      site.should_not be_nil
      site.subdomain.should == 'wdomain'
    end

    context 'invalid parameters' do
      it 'shows erros if there are' do
        fill_in('Website domain', with: nil )
        fill_in('Email',          with: nil )
        fill_in('Phone',          with: nil )
        fill_in('Street',         with: nil )
        fill_in('City',           with: nil )
        fill_in('Country',        with: nil )
        fill_in('Post code',      with: nil )

        click_on('Save')

        within(:css, "field[value='model.subdomain']") do
          page.should have_content("can't be blank")
        end
        within(:css, "field[value='model.email']") do
          page.should have_content("can't be blank")
        end
        within(:css, "field[value='model.phone']") do
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

      it 'shows server erros if there are' do
        another_user = FactoryGirl.create(:user_with_verified_identity)
        site         = FactoryGirl.create(:site, subdomain: 'test', user: another_user)
        fill_in('Website domain', with: 'test' )

        fill_in('Street',           with: '55 Oxford street' )
        fill_in('City',             with: 'London' )
        fill_in('Country',          with: 'UK' )
        fill_in('Post code',        with: 'W1D 2EQ' )

        page.should have_content('Address found: 55 Oxford Street')

        click_on('Save')

        page.should have_content("Subdomain has already been taken")
      end
    end
  end
end

