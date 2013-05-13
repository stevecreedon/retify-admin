class AddGoogleFormattedAddressToAddress < ActiveRecord::Migration
  def change
    add_column :addresses, :google_formatted_address, :string
  end
end
