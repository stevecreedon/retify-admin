class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.integer :source_id
      t.string  :source_type
      t.string  :title
      t.text    :description
      t.string  :group

      t.timestamps
    end
  end
end
