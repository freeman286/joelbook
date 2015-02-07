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
    if user.present?
			user.avatar.nil? ? user.gravatar_url + "?s=#{size}" : user.avatar.thumb(user.avatar_cropping).thumb("#{size}x#{size}").url
		else
			"http://placehold.it/#{size}x#{size}"
		end
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

  def link_to_notification_resource(notification)

  end

  def image_for_notification(notification, size, options)
    image_tag(avatar_url(notification.secondary_owner_user, size="25"), options)
  end
end
