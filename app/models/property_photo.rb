# == Schema Information
#
# Table name: property_photos
#
#  id          :integer          not null, primary key
#  image       :string(255)
#  property_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class PropertyPhoto < ActiveRecord::Base
  include Rails.application.routes.url_helpers
  attr_accessible :image, :property

  belongs_to :property

  mount_uploader :image, PhotoUploader

  validates :property, presence: true

  #one convenient method to pass jq_upload the necessary information
  def to_jq_upload
    {
      "name" => read_attribute(:image),
      "size" => image.size,
      "url" => image.url,
      "thumbnail_url" => image.thumb.url,
      "show_url" => property_photo_path(property_id: property.id, id: id),
    }
  end
end
