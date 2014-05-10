class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :avatar
  # attr_accessible :title, :body

  has_many :posts
  
  dragonfly_accessor :avatar  
    
  validates_presence_of :name
  validates_uniqueness_of :name
  
  def auth
    Digest::MD5.hexdigest(self.name + self.encrypted_password)
  end
  
  def avatar_url  
    self.avatar.nil? ? nil : self.avatar.thumb('80x80#').url
  end
  
  def self.current
    Thread.current[:user]
  end
  
  def self.current=(user)
    Thread.current[:user] = user
  end
end
