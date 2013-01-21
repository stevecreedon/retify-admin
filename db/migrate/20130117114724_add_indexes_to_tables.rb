class AddIndexesToTables < ActiveRecord::Migration
  def change
    add_index :sites, :subdomain
    add_index :sites, :domain

    add_index :properties, :site_id

    add_index :articles, [:source_type, :source_id]
  end
end
