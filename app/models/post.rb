class Post < ActiveRecord::Base
  attr_accessible :num_pages, :title
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
end
