class DropEmailVerifiedFromIdentity < ActiveRecord::Migration
  def up
    remove_column(:identities, :email_verified)
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
