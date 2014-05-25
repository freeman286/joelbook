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
end
