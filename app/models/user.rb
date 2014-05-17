class User < ActiveRecord::Base
  after_save :update_posts
    # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :current_password, :remember_me, :name, :avatar, :avatar_cropping, :avatar_width, :avatar_height
  # attr_accessible :title, :body
  attr_accessor :current_password

  has_many :posts
  
  dragonfly_accessor :avatar
  validates_property :format, of: :avatar, in: ['jpeg', 'png', 'gif']  
    
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
  
  def crop_array
    if self.avatar_cropping.nil?
      [ 0, 0, 240, 240 ]
    else
      cropping = self.avatar_cropping.split(/[^\d]/)
      array = []
      array << (cropping[2].to_i + cropping[0].to_i / 2).to_s
      array << (cropping[3].to_i + cropping[0].to_i / 2).to_s
      array << (cropping[2].to_i - cropping[0].to_i / 2).to_s
      array << (cropping[3].to_i - cropping[0].to_i / 2).to_s
      array
    end
  end
end
