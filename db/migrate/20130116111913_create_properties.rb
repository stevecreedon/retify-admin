class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.string  :title
      t.text    :description
      t.integer :site_id
      t.integer :address_id
      t.integer :user_id

      t.timestamps
    end
  end
end
