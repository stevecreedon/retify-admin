class CalendarSerializer < ActiveModel::Serializer
  attributes :id, :provider, :path, :property_id

  def attributes
    hash = super
    hash[:errors] = object.errors.full_messages
    hash
  end
end
