class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :channel

  attr_accessible :user_name, :name, :img_url, :youtube_url, :user_img_url, :user_id, :channel_id, :time, :can_be_viewed

  has_one :image
  has_one :video

  before_create :check_can_be_viewed

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
      self.channel.update_attribute(:updated_at, Time.now)
      if self.channel.private? && action == 'create'
        Notification.create(
          :owner_user_id => self.channel.owner_user_id == User.current.id ? self.channel.secondary_owner_user_id : self.channel.owner_user_id,
          :secondary_owner_user_id => User.current.id,
          :resource_type => "Channel",
          :resource_id => self.channel.id,
          :content => "#{User.current.name} says '#{self.name}'",
          :read => false
        )
      end
    end
  end

  validates :user_name, presence: true
  validates :channel_id, presence: true
  validates :name, presence: true
  validate :can_be_published?

  def can_be_published?
    if !(User.current && User.current.name == self.user_name)
      errors.add(:user_name, "does not match current user")
    end
    if !(self.channel && (self.channel.public == true || self.channel.includes_user?(User.current)))
      errors.add(:channel, "user is not member of channel")
    end
  end

  def check_can_be_viewed
    if self.channel.public?
      self.can_be_viewed = true
    else
      self.can_be_viewed = false
    end
    true
  end
end
