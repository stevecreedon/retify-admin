class Calendar < ActiveRecord::Base
  attr_accessible :enabled, :path, :provider, :property_id

  belongs_to :property
end
