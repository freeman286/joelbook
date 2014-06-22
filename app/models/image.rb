class Image < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  
  attr_accessible :image_uid, :image_name, :user_id, :post_id
  
  dragonfly_accessor :image
  validates_property :format, of: :image, in: ['jpeg', 'png', 'gif']  

end