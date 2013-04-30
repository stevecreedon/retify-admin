class SiteSerializer < ActiveModel::Serializer
  attributes :id, :title, :subdomain, :domain, :style, :email, :phone, :address_id, :user_id, :google_analytics

  has_one :address
  has_one :user

  def attributes
    hash = super
    hash[:errors] = object.errors.full_messages
    hash
  end
end
