class AddGoogleAnalyticsToSite < ActiveRecord::Migration
  def change
    add_column :sites, :google_analytics, :string
  end
end
