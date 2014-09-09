class Channel < ActiveRecord::Base
  has_and_belongs_to_many :users

  belongs_to :owner_user, class_name: 'User', foreign_key: 'owner_user_id'
  belongs_to :secondary_owner_user, class_name: 'User', foreign_key: 'secondary_owner_user_id'

  has_many :posts, dependent: :destroy

  attr_accessible :owner_user_id, :secondary_owner_user_id, :name, :private, :public, :page



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
        channels << User.current.channels.where(['lower(name) LIKE ?', "%#{keyword.downcase}%"]) + Channel.where(['lower(name) LIKE ?', "%#{keyword.downcase}%"]).select {|c| c.public?}
      end
      (channels.first - channels.first.select {|c| c.private?}).uniq
    else
      channels << User.current.channels.where(:private => nil) + Channel.where(:public => true)
      channels.first.uniq
    end
  end
end
