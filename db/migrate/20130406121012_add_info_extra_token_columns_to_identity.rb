class AddInfoExtraTokenColumnsToIdentity < ActiveRecord::Migration
  def up
    add_column(:identities, :info, :text)
    add_column(:identities, :credentials, :text)
    add_column(:identities, :extra, :text)

    PasswordIdentity.all.each do |pi|
      pi.info = {}
      pi.info[:email] = pi.email
      pi.info[:name] = pi.name
      pi.save!
    end

    remove_column(:identities, :email)
    remove_column(:identities, :name)


  end

  def down
    remove_column(:identities, :info)
    remove_column(:identities, :credentials)
    remove_column(:identities, :extra)
  end
end
