class AddressSerializer < ActiveModel::Serializer
  attributes :id, :address, :country, :city, :state, :post_code, :lat, :lng, :user_set_lat, :user_set_lng, :google_formatted_address
end
