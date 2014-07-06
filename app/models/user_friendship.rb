class UserFriendship < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, class_name: 'User', foreign_key: 'friend_id'

  attr_accessible :user, :friend, :user_id, :friend_id, :state
  
  after_destroy :update_last_destroy
  after_destroy :delete_mutual_friendship!
  
  validate :not_blocked
  
  after_create {|friendship| friendship.notify_user 'create' }
  after_update {|friendship| friendship.notify_user 'update' }
  
  def self.request(user1, user2)
    transaction do
      friendship1 = create!(user: user1, friend: user2, state: 'pending')
      friendship2 = create!(user: user2, friend: user1, state: 'requested')
      
      friendship1
    end
  end
  
  def not_blocked
    if UserFriendship.exists?(user_id: user_id, friend_id: friend_id, state: 'blocked') || UserFriendship.exists?(user_id: friend_id, friend_id: user_id, state: 'blocked')
      errors.add(:base, "The friendship cannot be added.")
    end
  end
  
  def mutual_friendship
    self.class.where({user_id: friend_id, friend_id: user_id}).first
  end

  def accept_mutual_friendship!
    mutual_friendship.update_attribute(:state, 'accepted')
  end
  
  def decline_mutual_friendship!
    mutual_friendship.update_attribute(:state, 'declined')
  end

  def delete_mutual_friendship!
    mutual_friendship.delete if mutual_friendship
  end
  
  
  def accepted?
    self.state == 'accepted'
  end
  
  def requested?
    self.state == 'requested'
  end
  
  def blocked?
    self.state == 'blocked'
  end
  
  def declined?
    self.state == 'declined'
  end
  
  def ignored?
    self.state == 'ignored'
  end
  
  def pending?
    self.state == 'pending'
  end
  
  def state_to_name
    if self.state == 'pending'
      'requested'
    else
      self.state
    end
  end
    
  def notify_user action
    case action
    when 'create'
      if self.requested?
        Notification.create(
          :owner_user_id => self.user.id,
          :secondary_owner_user_id => self.friend.id,
          :resource_type => "UserFriendship",
          :resource_id => self.id,
          :content => "#{self.friend.name} wants to be friends with you",
          :read => false
        )
      end
    when 'update'
      if self.user != User.current
        Notification.create(
          :owner_user_id => self.user.id,
          :secondary_owner_user_id => self.friend.id,
          :resource_type => "UserFriendship",
          :resource_id => self.id,
          :content => "#{self.friend.name} has become friends with you",
          :read => false
        )
      end
    end  
  end
  
  def update_last_destroy
    user = self.user
    friend = self.friend
    case self.state
    when 'accepted'
      user.last_destroyed_user_friendship_at =
      user.last_destroyed_accepted_user_friendship_at =
      friend.last_destroyed_user_friendship_at =
      friend.last_destroyed_accepted_user_friendship_at = Time.now
    when 'pending'
      user.last_destroyed_user_friendship_at =
      user.last_destroyed_pending_user_friendship_at =
      friend.last_destroyed_user_friendship_at =
      friend.last_destroyed_pending_user_friendship_at = Time.now
    when 'requested'
      user.last_destroyed_user_friendship_at =
      user.last_destroyed_pending_user_friendship_at =
      friend.last_destroyed_user_friendship_at =
      friend.last_destroyed_pending_user_friendship_at = Time.now
    when 'blocked'
      user.last_destroyed_user_friendship_at = 
      user.last_destroyed_blocked_user_friendship_at = Time.now
    when 'ignored'
      user.last_destroyed_user_friendship_at =
      user.last_destroyed_ignored_user_friendship_at = Time.now
    end
    user.save
    friend.save
  end
end