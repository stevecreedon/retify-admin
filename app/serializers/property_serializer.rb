class PropertySerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :address_id, :updated_at

  has_one  :address
  has_many :directions
  has_many :photos
  has_many :calendars
  has_many :articles

  def attributes
    hash = super
    hash[:errors] = object.errors.full_messages
    hash
  end

  def include_associations!
    include! :address
    unless options[:include_associations] === false
      include! :directions
      include! :photos
      include! :calendars
      include! :articles
    end
  end
end
