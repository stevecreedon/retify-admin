# == Schema Information
#
# Table name: articles
#
#  id          :integer          not null, primary key
#  source_id   :integer
#  source_type :string(255)
#  title       :string(255)
#  description :text
#  group       :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

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
