class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :phone

  has_one :password_identity
  has_one :google_identity
end
