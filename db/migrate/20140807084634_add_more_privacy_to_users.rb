class AddMorePrivacyToUsers < ActiveRecord::Migration
  def change
    add_column :users, :images_visable_to_friends, :boolean, :default => true
    add_column :users, :email_visable_to_friends, :boolean, :default => true
    add_column :users, :friends_visable_to_friends, :boolean, :default => true
    add_column :users, :can_be_messaged_by_friends, :boolean, :default => true
  end
end
