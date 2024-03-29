class CreateIdentities < ActiveRecord::Migration
  def change
    create_table :identities do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :provider
      t.integer :user_id

      t.timestamps
    end
  end
end
