class AddPropertyDescriptionTitleUser < ActiveRecord::Migration

  def change
    add_column :properties, :title, :string
    add_column :properties, :description, :text
    add_column :properties, :userd_id, :integer
  end

end
