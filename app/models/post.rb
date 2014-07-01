class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :channel

  attr_accessible :user_name, :name, :img_url, :youtube_url, :user_img_url, :user_id, :channel_id, :time
  
  has_one :image

  after_create {|post| post.message 'create' }
  after_update {|post| post.message 'update' }
  after_destroy {|post| post.message 'destroy' }

  def message action
    msg = { resource: 'posts',
            action: action,
            id: self.id,
            obj: self,
           }   
    
    if can_be_published?
      $redis.publish 'rt-change', msg.to_json
    end
    
    if self.channel.private?
      Notification.create(
        :owner_user_id => self.channel.owner_user_id == User.current.id ? self.channel.secondary_owner_user_id : self.channel.owner_user_id,
        :secondary_owner_user_id => User.current.id,
        :resource_type => "UserFriendship",
        :resource_id => self.id,
        :content => "#{User.current.name} says '#{self.name}'",
        :read => false
      )
    end
  end

  validates :user_name, presence: true
  validates :channel_id, presence: true
  validates :name, presence: true
  validate :can_be_published?
  
  def can_be_published?
    User.current && User.current.name == self.user_name && (self.channel && (self.channel.public == true || self.channel.includes_user?(User.current)))
  end
end
