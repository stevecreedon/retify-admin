class CreateCalendars < ActiveRecord::Migration
  def change
    create_table :calendars do |t|
      t.string  :path
      t.string  :provider
      t.boolean :enabled
      t.integer :property_id

      t.timestamps
    end

    add_index :calendars, :property_id
    add_index :calendars, [:provider, :property_id]
  end
end
