class GoogleIdentitySerializer < ActiveModel::Serializer
  attributes :id, :email, :info, :state, :provider

  def attributes
    hash = super
    hash[:errors] = object.errors.full_messages
    hash
  end
end
