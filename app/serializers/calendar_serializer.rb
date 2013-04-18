class CalendarSerializer < ActiveModel::Serializer
  attributes :id, :provider, :path, :property_id

  def attributes
    hash = super
    hash[:errors] = {
      messages:      object.errors.messages,
      full_messages: object.errors.full_messages
    }
    hash
  end
end
