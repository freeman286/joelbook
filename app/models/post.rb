class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :channel

  attr_accessible :user_name, :name, :img_url, :youtube_url, :user_img_url, :user_id, :channel_id, :time

  after_create {|post| post.message 'create' }
  after_update {|post| post.message 'update' }
  after_destroy {|post| post.message 'destroy' }

  def message action
    msg = { resource: 'posts',
            action: action,
            id: self.id,
            obj: self,
           }   
    
    if User.current && User.current.name == self.user_name && (self.channel && (self.channel.public == true || self.channel.includes_user?(User.current)))
      $redis.publish 'rt-change', msg.to_json
    else
      self.destroy
    end
  end

  validates :user_name, presence: true
  validates :channel_id, presence: true
  validates :name, presence: true

end
