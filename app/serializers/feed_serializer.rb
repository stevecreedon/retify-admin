class FeedSerializer < ActiveModel::Serializer
  attributes :id, :template, :title, :icon, :user_id, :parent_id

  has_one  :user
end
