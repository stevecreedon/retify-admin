# == Schema Information
#
# Table name: directions
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :text
#  property_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Direction < ActiveRecord::Base
  attr_accessible :description, :property_id, :title

  belongs_to :property

  TYPES = [
    'By foot',
    'By car',
    'By bus',
    'By train',
    'By plane'
  ]
  
end
