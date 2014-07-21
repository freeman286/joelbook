class AddPrivacyToUsers < ActiveRecord::Migration
  def change
    add_column :users, :images_visable, :boolean, :default => true
    add_column :users, :email_visable, :boolean, :default => true
    add_column :users, :friends_visable, :boolean, :default => true
    add_column :users, :can_be_messaged, :boolean, :default => true
  end
end
