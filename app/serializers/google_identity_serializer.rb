class GoogleIdentitySerializer < ActiveModel::Serializer
  attributes :id, :email, :info, :state, :provider

  def attributes
    hash = super
    hash[:errors] = {
      messages:      object.errors.messages,
      full_messages: object.errors.full_messages
    }
    hash
  end
end
