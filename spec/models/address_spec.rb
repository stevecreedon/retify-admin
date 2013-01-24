require 'spec_helper'

describe Address do
  def valid_attributes  
    {
      address:      '1th line of Address',
      address2:     '1th line of Address',
      state:        'State',
      city:         'City',
      country:      'Country',
      post_code:    'Post code',
      lat:          1.1,
      lng:          1.1,
      user_set_lat: 2.2,
      user_set_lng: 2.2
    }
  end

  context 'with valid attributes' do
    it 'should be valid if all attributes present' do
      site = Address.new(valid_attributes)
      site.valid?.should be_true
    end
  end

  context 'with invalid attributes' do
    it 'should be not valid if the address is not set' do
      site = Address.new(valid_attributes.except(:address))
      site.valid?.should be_false
      site.errors.to_a.should include("Address can't be blank")
    end

    it 'should be not valid if the city is not set' do
      site = Address.new(valid_attributes.except(:city))
      site.valid?.should be_false
      site.errors.to_a.should include("City can't be blank")
    end

    it 'should be not valid if the country is not set' do
      site = Address.new(valid_attributes.except(:country))
      site.valid?.should be_false
      site.errors.to_a.should include("Country can't be blank")
    end

    it 'should be not valid if the post code is not set' do
      site = Address.new(valid_attributes.except(:post_code))
      site.valid?.should be_false
      site.errors.to_a.should include("Post code can't be blank")
    end

  end
end
