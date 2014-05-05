class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  after_create :get_gravatar
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :avatar
  # attr_accessible :title, :body

  has_many :posts
  
  has_attached_file :avatar, styles: {
    large: "800x800#", medium: "300x200#", small: "260x180#", thumb: "80x80#"
  }
  
  validates_attachment_content_type :avatar, :content_type => ["image/jpg", "image/jpeg", "image/png"]
  
  validates_presence_of :name
  validates_uniqueness_of :name
  
  def auth
    Digest::MD5.hexdigest(self.name + self.encrypted_password)
  end
  
  def gravatar_url
    stripped_email = email.strip
    downcase_email = stripped_email.downcase
    hash = Digest::MD5.hexdigest(downcase_email)

    "http://gravatar.com/avatar/#{hash}"
  end
  
  def get_gravatar
    if !self.avatar?
       self.avatar = URI.parse(self.gravatar_url)
       self.save
    end
  end
  
  def avatar_url
    self.avatar? ? self.avatar.url(:thumb) : nil
  end
end
