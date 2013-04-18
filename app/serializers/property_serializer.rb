class PropertySerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :address_id

  has_one :address

  def attributes
    hash = super
    hash[:errors] = {
      messages:      object.errors.messages,
      full_messages: object.errors.full_messages
    }
    hash
  end
end
