class DeleteProviderAndPasswordDigestFromUsersTable < ActiveRecord::Migration
  def up
    remove_column :users, :provider
    remove_column :users, :password_digest
  end

  def down
  end
end
