module ApplicationHelper
	def flash_class(type)
		case type
		when :alert
			"alert-danger"
		when :notice
			"alert-info"
		else
			""
		end
	end
  
  def avatar_url(user, size="80")
    user.avatar.nil? ? user.gravatar_url + "?s=#{size}" : user.avatar.thumb(user.avatar_cropping).thumb("#{size}x#{size}").url
  end
  
  def update_action_verbiage(friendship)
  case friendship.state
    when 'pending'
      'Delete request'
    when 'requested'
      'Accept'
    when 'declined'
      'Accept'  
    when 'accepted'
      'Unfriend'
    when 'blocked'
      'Unblock User'
    end
  end
end
