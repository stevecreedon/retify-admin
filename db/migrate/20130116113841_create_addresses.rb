class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :address
      t.string :address2
      t.string :country
      t.string :city
      t.string :state
      t.string :post_code
      t.float :lat
      t.float :lng
      t.float :user_set_lat
      t.float :user_set_lng

      t.timestamps
    end
  end
end
