class CreateDirections < ActiveRecord::Migration
  def change
    create_table :directions do |t|
      t.string :title
      t.text :description
      t.integer :property_id

      t.timestamps
    end
  end
end
