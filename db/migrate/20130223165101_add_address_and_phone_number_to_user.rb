class AddAddressAndPhoneNumberToUser < ActiveRecord::Migration
  def change
    add_column :users, :address_id, :integer
    add_column :users, :phone,      :string
  end
end
