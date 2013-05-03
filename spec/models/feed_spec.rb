require 'spec_helper'

describe Feed do
  def valid_attributes  
    {
      feed_type:   :feed_type,
      title:       'Feed title',
      template:    'path/to/template',
      icon:        'icon-name',
      parent_id:   1,
      user:        FactoryGirl.create(:user_with_verified_identity),
    }
  end

  context 'with valid attributes' do
    it 'should be valid if all attributes present' do
      feed = Feed.create(valid_attributes)
      feed.valid?.should be_true
    end

    it 'should be valid if the parent_id is not set' do
      feed = Feed.create(valid_attributes.except(:parent_id))
      feed.valid?.should be_true
    end
  end

  context 'with invalid attributes' do
    it 'should be not valid if the feed_type is not set' do
      feed = Feed.create(valid_attributes.except(:feed_type))
      feed.valid?.should be_false
      feed.errors.to_a.should include("Feed type can't be blank")
    end

    it 'should be not valid if the user is not set' do
      feed = Feed.create(valid_attributes.except(:user))
      feed.valid?.should be_false
      feed.errors.to_a.should include("User can't be blank")
    end

    it 'should be not valid if the title is not set' do
      feed = Feed.create(valid_attributes.except(:title))
      feed.valid?.should be_false
      feed.errors.to_a.should include("Title can't be blank")
    end

    it 'should be not valid if the template is not set' do
      feed = Feed.create(valid_attributes.except(:template))
      feed.valid?.should be_false
      feed.errors.to_a.should include("Template can't be blank")
    end

  end
end
