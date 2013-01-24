class Address < ActiveRecord::Base
  attr_accessible :address, :address2, :city, :country, :lat, :lng, :post_code, :state, :user_set_lat, :user_set_lng

  validates :address,   presence: true
  validates :city,      presence: true
  validates :country,   presence: true
  validates :post_code, presence: true
end
