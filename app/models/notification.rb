class Notification < ActiveRecord::Base  
  belongs_to :owner_user, class_name: 'User', foreign_key: 'owner_user_id'
  belongs_to :secondary_owner_user, class_name: 'User', foreign_key: 'secondary_owner_user_id'
  belongs_to :resource, :polymorphic => true

  attr_accessible :owner_user_id, :secondary_owner_user_id, :resource_type, :resource_id, :content, :read

  validates :owner_user_id, presence: true
  validates :content, presence: true
  
  def resource_path
    polymorphic_path(resource_for_path)
  end
  
  def class_path
    self.resource_type.gsub(/::/, '/').
    gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
    gsub(/([a-z\d])([A-Z])/,'\1_\2').
    tr("-", "_").
    downcase + "s"
  end
  
  private
  def resource_for_path
    resource
  end
end