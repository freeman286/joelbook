class AddLastDestroyedUserFriendshipsAcceptedBlockedIgnoredToUsers < ActiveRecord::Migration
  def change
    add_column :users, :last_destroyed_user_friendship_at, :datetime
    add_column :users, :last_destroyed_accepted_user_friendship_at, :datetime
    add_column :users, :last_destroyed_blocked_user_friendship_at, :datetime
    add_column :users, :last_destroyed_ignored_user_friendship_at, :datetime
  end
end
