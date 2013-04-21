class DirectionSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :property_id

  def attributes
    hash = super
    hash[:errors] = {
      messages:      object.errors.messages,
      full_messages: object.errors.full_messages
    }
    hash
  end
end
