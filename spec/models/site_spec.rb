require 'spec_helper'

describe Site do
  def valid_attributes  
    {
      title:     'Site title',
      subdomain: 'example',
      domain:    'www.example.com',
      style:     'style_01',
      email:     'test@domain.com',
      phone:     '09876544331',
      user:      FactoryGirl.create(:user_with_identity),
      address:   FactoryGirl.create(:address)
    }
  end

  context 'with valid attributes' do
    it 'should be valid if all attributes present' do
      site = Site.new(valid_attributes)
      site.valid?.should be_true
    end
  end

  context 'with invalid attributes' do
    it 'should be not valid if the user is not set' do
      site = Site.new(valid_attributes.except(:user))
      site.valid?.should be_false
      site.errors.to_a.should include("User can't be blank")
    end

    it 'should be not valid if the phone is not set' do
      site = Site.new(valid_attributes.except(:phone))
      site.valid?.should be_false
      site.errors.to_a.should include("Phone can't be blank")
    end

    it 'should be not valid if the email is not set' do
      site = Site.new(valid_attributes.except(:email))
      site.valid?.should be_false
      site.errors.to_a.should include("Email can't be blank")
    end

    it 'should be not valid if the email is in incorrect format' do
      site = Site.new(valid_attributes.merge(email: 'aaaa'))
      site.valid?.should be_false
      site.errors.to_a.should include("Email is invalid")
    end

    it 'should be not valid if the style is not set' do
      site = Site.new(valid_attributes.except(:style))
      site.valid?.should be_false
      site.errors.to_a.should include("Style can't be blank")
    end

    it 'should be not valid if the subdomain is not set' do
      site = Site.new(valid_attributes.except(:subdomain))
      site.valid?.should be_false
      site.errors.to_a.should include("Subdomain can't be blank")
    end

    it 'should be not valid if the subdomain is not unique' do
      Site.create(valid_attributes.merge(subdomain: 'subdomain'))
      site = Site.new(valid_attributes.merge(subdomain: 'subdomain'))
      site.valid?.should be_false
      site.errors.to_a.should include("Subdomain has already been taken")
    end

    it 'should be not valid if the domain is not unique' do
      Site.create(valid_attributes.merge(domain: 'domain', subdomain: 'sub1'))
      site = Site.new(valid_attributes.merge(domain: 'domain', subdomain: 'sub2'))
      site.valid?.should be_false
      site.errors.to_a.should include("Domain has already been taken")
    end

  end

end
