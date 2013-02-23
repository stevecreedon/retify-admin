class AddStateToIdentity < ActiveRecord::Migration
  def change
    add_column :identities, :state, :string
  end
end
