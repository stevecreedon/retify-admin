class AddressSerializer < ActiveModel::Serializer
  attributes :id, :address, :address2, :country, :city, :state, :post_code
end
