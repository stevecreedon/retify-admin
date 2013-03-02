class AddTypeToToken < ActiveRecord::Migration
  def change
    add_column :identity_tokens, :type, :string
    remove_column :identity_tokens, :purpose
  end
end
