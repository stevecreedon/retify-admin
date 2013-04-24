class PropertySerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :address_id, :updated_at

  has_one  :address
  has_many :directions
  has_many :photos
  has_many :calendars
  has_many :articles

  def attributes
    hash = super
    hash[:errors] = {
      messages:      object.errors.messages,
      full_messages: object.errors.full_messages
    }
    hash
  end

  def include_associations!
    unless options[:include_associations] === false
      include! :address
      include! :directions
      include! :photos
      include! :calendars
      include! :articles
    end
  end
end
