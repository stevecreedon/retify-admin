class CreateIdentityTokens < ActiveRecord::Migration
  def change
    create_table :identity_tokens do |t|
      t.integer :user_id
      t.string :guid
      t.timestamps
    end
  end
end
