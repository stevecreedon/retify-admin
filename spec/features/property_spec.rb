require 'spec_helper'

describe 'property page', js: true do
  let(:user)    { FactoryGirl.create(:user_with_identity) }

  before do
    sign_in(user)
    visit app_path
  end

  it 'shows all properties' do
    property = FactoryGirl.create(:property, user: user, title: 'House title',  description: 'house description')
   
    click_on('Properties')

    page.should have_content(property.title)

    click_on(property.title)

    page.should have_content("Property dashboard")

    within :css, "h4" do
      page.should have_content(property.title)
    end
  end
end

