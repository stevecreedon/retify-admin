# == Schema Information
#
# Table name: calendars
#
#  id          :integer          not null, primary key
#  path        :string(255)
#  provider    :string(255)
#  enabled     :boolean
#  property_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Calendar < ActiveRecord::Base
  attr_accessible :enabled, :path, :provider, :property

  belongs_to :property

  validates :provider, presence: true
  validates :path,     presence: true
  validates :property, presence: true
end
