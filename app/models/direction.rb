class Direction < ActiveRecord::Base
  attr_accessible :description, :property_id, :title

  has_one :property
end
