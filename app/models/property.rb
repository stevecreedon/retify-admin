# == Schema Information
#
# Table name: properties
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :text
#  site_id     :integer
#  address_id  :integer
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Property < ActiveRecord::Base
  attr_accessible :description, :address, :title, :user, :user_id, :address_id

  belongs_to :user
  belongs_to :address

  has_many   :directions
  has_many   :photos, class_name: 'PropertyPhoto'
  has_many   :calendars
  has_many   :articles, conditions: { source_type: 'property' },
                        foreign_key: 'source_id',
                        dependent: :destroy

  accepts_nested_attributes_for :address

  validates :user,        presence: true
  validates :address,     presence: true
  validates :title,       presence: true
  validates :description, presence: true
end
