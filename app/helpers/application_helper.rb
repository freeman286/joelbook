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
  
  def avatar_url(user)
    user.avatar.nil? ? user.gravatar_url : user.avatar.thumb(user.avatar_cropping).thumb("80x80").url
  end
  
  def search_avatar_url(user)
    user.avatar.nil? ? user.gravatar_url + "?s=40"  : user.avatar.thumb(user.avatar_cropping).thumb("40x40").url
  end
end
