require 'spec_helper'

describe Feed do
  def valid_attributes  
    {
      feed_type:   :feed_type,
      title:       'Feed title',
      template:    'path/to/template',
      icon:        'icon-name',
      parent_id:   1,
      user:        FactoryGirl.create(:user_with_identity),
    }
  end

  context 'with valid attributes' do
    it 'should be valid if all attributes present' do
      site = Feed.new(valid_attributes)
      site.valid?.should be_true
    end

    it 'should be valid if the parent_id is not set' do
      site = Feed.new(valid_attributes.except(:parent_id))
      site.valid?.should be_true
    end
  end

  context 'with invalid attributes' do
    it 'should be not valid if the feed_type is not set' do
      site = Feed.new(valid_attributes.except(:feed_type))
      site.valid?.should be_false
      site.errors.to_a.should include("Feed type can't be blank")
    end

    it 'should be not valid if the user is not set' do
      site = Feed.new(valid_attributes.except(:user))
      site.valid?.should be_false
      site.errors.to_a.should include("User can't be blank")
    end

    it 'should be not valid if the title is not set' do
      site = Feed.new(valid_attributes.except(:title))
      site.valid?.should be_false
      site.errors.to_a.should include("Title can't be blank")
    end

    it 'should be not valid if the template is not set' do
      site = Feed.new(valid_attributes.except(:template))
      site.valid?.should be_false
      site.errors.to_a.should include("Template can't be blank")
    end

  end
end
