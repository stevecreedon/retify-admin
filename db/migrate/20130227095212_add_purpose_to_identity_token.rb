class AddPurposeToIdentityToken < ActiveRecord::Migration
  def change
    add_column :identity_tokens, :purpose, :string
    add_column :identity_tokens, :valid_until, :datetime
  end
end
