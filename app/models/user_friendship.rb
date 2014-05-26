class UserFriendship < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, class_name: 'User', foreign_key: 'friend_id'

  attr_accessible :user, :friend, :user_id, :friend_id, :state
  
  after_destroy :delete_mutual_friendship!
  
  validate :not_blocked
  
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
end