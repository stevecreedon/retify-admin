class DeleteEmailFromUser < ActiveRecord::Migration
  def up
    remove_column :users, :email
  end

  def down
    add_column :users, :email, :string

    User.all do | user |
      user.email = user.identities.first.email
    end
  end
end
