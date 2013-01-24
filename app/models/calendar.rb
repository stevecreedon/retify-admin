class Calendar < ActiveRecord::Base
  attr_accessible :enabled, :path, :provider, :property

  belongs_to :property

  validates :provider, presence: true
  validates :path,     presence: true
  validates :property, presence: true
end
