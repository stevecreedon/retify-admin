require 'spec_helper'

describe Calendar do
  def valid_attributes  
    {
      provider:    'google',
      path:        'path_to_calendar',
      enabled:     true,
      property:    FactoryGirl.create(:property)
    }
  end

  context 'with valid attributes' do
    it 'should be valid if all attributes present' do
      site = Calendar.new(valid_attributes)
      site.valid?.should be_true
    end
  end

  context 'with invalid attributes' do
    it 'should be not valid if the provider is not set' do
      site = Calendar.new(valid_attributes.except(:provider))
      site.valid?.should be_false
      site.errors.to_a.should include("Provider can't be blank")
    end

    it 'should be not valid if the path is not set' do
      site = Calendar.new(valid_attributes.except(:path))
      site.valid?.should be_false
      site.errors.to_a.should include("Path can't be blank")
    end

    it 'should be not valid if the property is not set' do
      site = Calendar.new(valid_attributes.except(:property))
      site.valid?.should be_false
      site.errors.to_a.should include("Property can't be blank")
    end

  end
end
