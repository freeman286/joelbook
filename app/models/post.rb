class Post < ActiveRecord::Base
  belongs_to :user

  attr_accessible :user_id, :name, :img_url, :youtube_url

  after_create {|post| post.message 'create' }
  after_update {|post| post.message 'update' }
  after_destroy {|post| post.message 'destroy' }

  def message action
    msg = { resource: 'posts',
            action: action,
            id: self.id,
            obj: self }

    $redis.publish 'rt-change', msg.to_json
  end

  validates :user_id, presence: true
end
