class DropGuidFromUser < ActiveRecord::Migration
  def up
    remove_column :users, :guid
  end

  def down
    add_column :users, :guid, :string
  end
end
