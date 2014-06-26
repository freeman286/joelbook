class Channel < ActiveRecord::Base
  has_and_belongs_to_many :users
  
  belongs_to :owner_user, class_name: 'User', foreign_key: 'owner_user_id'
  belongs_to :secondary_owner_user, class_name: 'User', foreign_key: 'secondary_owner_user_id'
  
  has_many :posts

  attr_accessible :owner_user_id, :secondary_owner_user_id, :name, :private, :public



  validates :owner_user_id, presence: true
  validates :secondary_owner_user_id, presence: true, if: :private?

  validates :name, presence: true
  
  def includes_user?(user)
    self.users.include?(user)
  end
  
  def current_user_valid
    User.current && self.owner_user == User.current
  end
  
  def self.find_private_channel(user_1, user_2)
    (Channel.where(:owner_user_id => user_1.id, :secondary_owner_user_id => user_2.id, :private => true) + Channel.where(:owner_user_id => user_2.id, :secondary_owner_user_id => user_1.id, :private => true)).first
  end
  
  def self.search(words)
    channels = Set.new

    if words.present?
    words.split(" ").each do |keyword|
      channels << where(['name LIKE ?', "%#{keyword}%"])
      channels << where(['name LIKE ?', "%#{keyword.capitalize}%"])
    end
    channels.first - Channel.select {|c| c.private?}
    else
      Channel.all - Channel.select {|c| c.private?}
    end
  end
end

