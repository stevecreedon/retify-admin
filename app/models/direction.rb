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
