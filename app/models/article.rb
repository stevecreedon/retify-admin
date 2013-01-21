class Article < ActiveRecord::Base
  attr_accessible :description, :group, :source_id, :source_type, :title
end
