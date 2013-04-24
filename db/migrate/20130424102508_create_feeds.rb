class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.string  :feed_type
      t.string  :template
      t.string  :title
      t.string  :icon
      t.integer :user_id
      t.integer :parent_id

      t.timestamps
    end
  end
end
