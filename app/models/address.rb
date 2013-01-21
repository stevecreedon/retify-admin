class Address < ActiveRecord::Base
  attr_accessible :address, :address2, :city, :country, :lat, :lng, :post_code, :state, :user_set_lat, :user_set_lng
end
