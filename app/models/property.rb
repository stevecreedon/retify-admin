class Property < ActiveRecord::Base
  attr_accessible :description, :site_id, :address_id, :title

  belongs_to :user

  has_one  :site
  has_one  :address

  has_many :directions
  has_many :calendars
  has_many :articles, conditions: { source_type: 'property' },
                      foreign_key: 'source_id',
                      dependent: :destroy
end
