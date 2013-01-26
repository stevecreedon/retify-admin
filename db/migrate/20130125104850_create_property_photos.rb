class CreatePropertyPhotos < ActiveRecord::Migration
  def change
    create_table :property_photos do |t|
      t.string :image
      t.integer :property_id

      t.timestamps
    end
  end
end
