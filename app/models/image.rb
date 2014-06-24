class Image < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  
  attr_accessible :image, :user_id, :post_id, :original_image_url
  
  dragonfly_accessor :image
  validates_property :format, of: :image, in: ['jpeg', 'png', 'gif']  

  def url
    self.original_image_url ? self.original_image_url : self.image.url
  end
  
end