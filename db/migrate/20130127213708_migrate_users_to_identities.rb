class MigrateUsersToIdentities < ActiveRecord::Migration
  def up
    puts "**********************************************"
    puts "*** IMPORTANT!!!!!!!!!!!!!! ******************"
    puts "*** IMPORTANT!!!!!!!!!!!!!! ******************"
    puts "*** IMPORTANT!!!!!!!!!!!!!! ******************"
    puts "*** IMPORTANT!!!!!!!!!!!!!! ******************"
    puts "*** all passwords reset to 'password' ********"
    puts "*** IMPORTANT!!!!!!!!!!!!!! ******************"
    puts "*** IMPORTANT!!!!!!!!!!!!!! ******************"
    puts "*** IMPORTANT!!!!!!!!!!!!!! ******************"
    puts "*** IMPORTANT!!!!!!!!!!!!!! ******************"
    puts "**********************************************"
     
    User.all.each do |user|
      user.identities.create(:name => user.name || user.email, :provider => "password", :password => "password", :email => user.email)
    end
  end

  def down
    Identity.delete_all
  end
end
