require 'spec_helper'

describe 'settings page' do
  context 'user from sign up page', js: true do
    let(:user)    { FactoryGirl.create(:user_with_verified_identity) }

    before do
      sign_in(user)
      visit app_path
    end

    context 'no site exisiting' do
      before do
        click_on('Settings')
      end

      it 'creates settings' do
        fill_in('Website domain',   with: 'wdomain' )
        fill_in('Street',           with: '55 Oxford street' )
        fill_in('City',             with: 'London' )
        fill_in('Country',          with: 'UK' )
        fill_in('Post code',        with: 'W1D 2EQ' )

        page.should have_content('Address found: 55 Oxford Street')

        click_on('Save')

        page.should have_content('Settings saved')
        page.should have_content('wdomain.lovebnb.com')

        user.reload
        user.feeds.where( feed_type: :create_site ).count.should == 0
        site = user.sites.first
        site.should_not be_nil
        site.subdomain.should        == 'wdomain'
      end
    end

    context 'with site' do
      before do
        FactoryGirl.create(:site, user: user)

        click_on('Settings')
      end

      it 'changes settings' do
        fill_in('Website domain',   with: 'wdomain' )
        fill_in('Custom domain',    with: 'www.hey.com' )
        fill_in('Google Analytics', with: 'UE-9393939-11' )

        click_on('Save')

        page.should have_content('Settings saved')

        user.reload
        site = user.sites.first
        site.should_not be_nil
        site.subdomain.should        == 'wdomain'
        site.domain.should           == 'www.hey.com'
        site.google_analytics.should == 'UE-9393939-11'
      end

      context 'invalid parameters' do
        it 'shows erros if there are' do
          fill_in('Website domain',   with: nil )
          fill_in('Custom domain',    with: nil )
          fill_in('Email',            with: nil )
          fill_in('Phone',            with: nil )
          fill_in('Street',           with: nil )
          fill_in('City',             with: nil )
          fill_in('Country',          with: nil )
          fill_in('Post code',        with: nil )
          fill_in('Google Analytics', with: nil )

          click_on('Save')

          within(:css, "field[value='site.subdomain']") do
            page.should have_content("can't be blank")
          end
          within(:css, "field[value='site.domain']") do
            page.should_not have_content("can't be blank")
          end
          within(:css, "field[value='site.email']") do
            page.should have_content("can't be blank")
          end
          within(:css, "field[value='site.phone']") do
            page.should have_content("can't be blank")
          end
          within(:css, "field[value='site.address.address']") do
            page.should have_content("can't be blank")
          end
          within(:css, "field[value='site.address.city']") do
            page.should have_content("can't be blank")
          end
          within(:css, "field[value='site.address.country']") do
            page.should have_content("can't be blank")
          end
          within(:css, "field[value='site.address.post_code']") do
            page.should have_content("can't be blank")
          end
          within(:css, "field[value='site.google_analytics']") do
            page.should_not have_content("can't be blank")
          end
        end

        it 'shows server erros if there are' do
          another_user = FactoryGirl.create(:user_with_verified_identity)
          site         = FactoryGirl.create(:site, subdomain: 'test', user: another_user)
          fill_in('Website domain', with: 'test' )

          click_on('Save')

          page.should have_content("Subdomain has already been taken")
        end
      end
    end
  end
end

