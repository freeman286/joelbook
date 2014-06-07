class CreateChannelsUsersTable < ActiveRecord::Migration
  def self.up
    create_table :channels_users, :id => false do |t|
      t.references :channel
      t.references :user
    end 
  end

  def self.down
    drop_table :channels_users
  end
end
