class User < ActiveRecord::Base
  after_save :update_posts
    # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :current_password, :remember_me, :name, :avatar, :avatar_cropping, :avatar_width, :avatar_height, :page
  # attr_accessible :title, :body
  attr_accessor :current_password

  has_many :posts
  
  has_and_belongs_to_many :channels
  
  has_many :user_friendships, dependent: :destroy

  has_many :friends, through: :user_friendships,
                     conditions: { user_friendships: {state: 'accepted' }},
                     dependent: :destroy
                   
  has_many :pending_user_friendships, class_name: 'UserFriendship',
                                      foreign_key: :user_id,
                                      conditions: { state: 'pending'},
                                         dependent: :destroy
                                    
                                    
  has_many :pending_friends, through: :pending_user_friendships, source: :friend, dependent: :destroy

  has_many :requested_user_friendships, class_name: 'UserFriendship',
                                      foreign_key: :user_id,
                                      conditions: { state: 'requested'}, dependent: :destroy
                                    
  has_many :requested_friends, through: :requested_user_friendships, source: :friend, dependent: :destroy

  has_many :blocked_user_friendships, class_name: 'UserFriendship',
                                      foreign_key: :user_id,
                                      conditions: { state: 'blocked'},
                                      dependent: :destroy
                                    
  has_many :blocked_friends, through: :blocked_user_friendships, source: :friend, dependent: :destroy

  has_many :accepted_user_friendships, class_name: 'UserFriendship',
                                      foreign_key: :user_id,
                                      conditions: { state: 'accepted'},    
                                      dependent: :destroy
                                    
  has_many :accepted_friends, through: :accepted_user_friendships, source: :friend, dependent: :destroy
  
  has_many :declined_user_friendships, class_name: 'UserFriendship',
                                      foreign_key: :user_id,
                                      conditions: { state: 'declined'},    
                                      dependent: :destroy
                                    
  has_many :declined_friends, through: :declined_user_friendships, source: :friend, dependent: :destroy
  
  has_many :ignored_user_friendships, class_name: 'UserFriendship',
                                      foreign_key: :user_id,
                                      conditions: { state: 'ignored'},    
                                      dependent: :destroy
                                    
  has_many :ignored_friends, through: :ignored_user_friendships, source: :friend, dependent: :destroy
  
  dragonfly_accessor :avatar
  validates_property :format, of: :avatar, in: ['jpeg', 'png', 'gif']
  
  has_many :images
    
  validates_presence_of :name
  validates_uniqueness_of :name
  
  def auth
    Digest::MD5.hexdigest(self.name + self.encrypted_password)
  end
  
  def avatar_url  
    self.avatar.nil? ? self.gravatar_url : self.avatar.thumb(self.avatar_cropping).thumb("80x80").url
  end
  
  def self.current
    Thread.current[:user]
  end
  
  def self.current=(user)
    Thread.current[:user] = user
  end
  
  def update_posts
    Post.where(:user_name => self.name).each do |post|
      post.user_img_url = self.avatar_url
      post.save
    end
  end
  
  def gravatar_url
    stripped_email = email.strip
    downcase_email = stripped_email.downcase
    hash = Digest::MD5.hexdigest(downcase_email)

    "http://gravatar.com/avatar/#{hash}"
  end
  
  def crop_hash
    self.avatar_cropping
    md = self.avatar_cropping.match('(\d+):(\d+):(\d+)x(\d+)')
    { :x => md[1], :y => md[2],  :width  => md[3], :height => md[4] }
  end
  
  def self.search(words, exceptions = [])
    users = Set.new

    words.split(" ").each do |keyword|
      users << where(['name LIKE ?', "%#{keyword}%"])
      users << where(['email LIKE ?', "%#{keyword}%"])
      users << where(['name LIKE ?', "%#{keyword.capitalize}%"])
    end
    users.first - exceptions
  end  
end
