class MoveValidateTokenFromUserToIdentity < ActiveRecord::Migration
  def up

    add_column(:identity_tokens, :password_identity_id, :integer)

    Tokens::ValidateEmail.all.each do |t|
      t.update_attribute(:password_identity_id, t.user_id)
      t.update_attribute(:user_id, nil)
    end

  end

  def down

    Tokens::ValidateEmail.all.each do |t|
      t.update_attribute(:user_id, t.password_identity_id)
    end

   remove_column(:identities, :password_identity_id)
  end
end
