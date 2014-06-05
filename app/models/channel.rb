class Channel < ActiveRecord::Base
  belongs_to :owner_user, class_name: 'User', foreign_key: 'owner_user_id'
  belongs_to :secondary_owner_user, class_name: 'User', foreign_key: 'secondary_owner_user_id'
  
  has_many :posts

  attr_accessible :owner_user_id, :secondary_owner_user_id, :name, :private



  validates :owner_user_id, presence: true
  validates :secondary_owner_user_id, presence: true, if: :private?

  validates :name, presence: true
  
  
  def private?
    self.private == true
  end
end