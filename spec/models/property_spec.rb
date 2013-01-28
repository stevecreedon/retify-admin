require 'spec_helper'

describe Property do
  def valid_attributes  
    {
      title:       'Property title',
      description: 'Property description',
      user:        FactoryGirl.create(:user_with_identity),
      address:     FactoryGirl.create(:address)
    }
  end

  context 'with valid attributes' do
    it 'should be valid if all attributes present' do
      site = Property.new(valid_attributes)
      site.valid?.should be_true
    end
  end

  context 'with invalid attributes' do
    it 'should be not valid if the user is not set' do
      site = Property.new(valid_attributes.except(:user))
      site.valid?.should be_false
      site.errors.to_a.should include("User can't be blank")
    end

    it 'should be not valid if the title is not set' do
      site = Property.new(valid_attributes.except(:title))
      site.valid?.should be_false
      site.errors.to_a.should include("Title can't be blank")
    end

    it 'should be not valid if the description is not set' do
      site = Property.new(valid_attributes.except(:description))
      site.valid?.should be_false
      site.errors.to_a.should include("Description can't be blank")
    end

    it 'should be not valid if the address is not set' do
      site = Property.new(valid_attributes.except(:address))
      site.valid?.should be_false
      site.errors.to_a.should include("Address can't be blank")
    end

  end
end
