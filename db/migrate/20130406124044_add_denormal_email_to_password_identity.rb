class AddDenormalEmailToPasswordIdentity < ActiveRecord::Migration
  def up
    add_column(:identities, :email, :string)
    PasswordIdentity.all.each do |pi|
      pi.email = pi.info[:email]
      pi.save!
    end
  end

  def down
    remove_column(:identities, :email)
  end
end
