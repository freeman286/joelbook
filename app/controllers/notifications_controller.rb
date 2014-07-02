class NotificationsController < ApplicationController
  def index
    @notifications = current_user.notifications
    current_user.notifications.each do |notification|
      notification.read = true
      notification.save
    end
  end
  
  def read
    current_user.notifications.limit(5).each do |notification|
      notification.read = true
      notification.save
    end
  end
end
