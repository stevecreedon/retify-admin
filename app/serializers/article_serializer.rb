class ArticleSerializer < ActiveModel::Serializer
  attributes :id, :group, :title, :description, :source_type, :source_id

  def attributes
    hash = super
    hash[:errors] = object.errors.full_messages
    hash
  end
end
