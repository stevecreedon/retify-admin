# == Schema Information
#
# Table name: addresses
#
#  id           :integer          not null, primary key
#  address      :string(255)
#  address2     :string(255)
#  country      :string(255)
#  city         :string(255)
#  state        :string(255)
#  post_code    :string(255)
#  lat          :float
#  lng          :float
#  user_set_lat :float
#  user_set_lng :float
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Address < ActiveRecord::Base
  attr_accessible :address, :address2, :city, :country, :lat, :lng, :post_code, :state, :user_set_lat, :user_set_lng

  validates :address,   presence: true
  validates :city,      presence: true
  validates :country,   presence: true
  validates :post_code, presence: true
end
