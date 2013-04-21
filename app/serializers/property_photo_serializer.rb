class PropertyPhotoSerializer < ActiveModel::Serializer
  attributes :id, :image, :property_id
end
