require 'spec_helper'

describe Article do
  def valid_attributes  
    {
      source_id:   1,
      source_type: 'property',
      group:       'terms',
      title:       'Article title',
      description: 'Article description',
    }
  end

  context 'with valid attributes' do
    it 'should be valid if all attributes present' do
      site = Article.new(valid_attributes)
      site.valid?.should be_true
    end
  end

  context 'with invalid attributes' do
    it 'should be not valid if the source_id is not set' do
      site = Article.new(valid_attributes.except(:source_id))
      site.valid?.should be_false
      site.errors.to_a.should include("Source can't be blank")
    end

    it 'should be not valid if the source_type is not set' do
      site = Article.new(valid_attributes.except(:source_type))
      site.valid?.should be_false
      site.errors.to_a.should include("Source type can't be blank")
    end

    it 'should be not valid if the source_type is not in list' do
      site = Article.new(valid_attributes.merge(source_type: 'property'))
      site.valid?.should be_true
      site.source_type = 'something'
      site.valid?.should be_false
      site.errors.to_a.should include("Source type is not included in the list")
    end

    it 'should be not valid if the title is not set' do
      site = Article.new(valid_attributes.except(:title))
      site.valid?.should be_false
      site.errors.to_a.should include("Title can't be blank")
    end

    it 'should be not valid if the description is not set' do
      site = Article.new(valid_attributes.except(:description))
      site.valid?.should be_false
      site.errors.to_a.should include("Description can't be blank")
    end

    it 'should be not valid if the group is not set' do
      site = Article.new(valid_attributes.except(:group))
      site.valid?.should be_false
      site.errors.to_a.should include("Group can't be blank")
    end

    it 'should be not valid if the group is not in list' do
      site = Article.new(valid_attributes.merge(group: 'terms'))
      site.valid?.should be_true
      site.group = 'availability'
      site.valid?.should be_true
      site.group = 'something'
      site.valid?.should be_false
      site.errors.to_a.should include("Group is not included in the list")
    end

  end
end
