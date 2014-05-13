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
end
