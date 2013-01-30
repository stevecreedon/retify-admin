class Article < ActiveRecord::Base
  attr_accessible :description, :group, :source_id, :source_type, :title

  validates :source_id,   presence: true
  validates :source_type, presence: true,
                          inclusion: { in: %w(property) }
  validates :group,       presence: true,
                          inclusion: { in: %w(terms availability) }
  validates :title,       presence: true
  validates :description, presence: true
end
