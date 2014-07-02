class NotificationsController < ApplicationController
  def index
    @notifications = current_user.notifications
    
    respond_to do |format|
      format.html {
        @notifications.each do |notification|
          notification.read = true
          notification.save
        end
      }
      format.json { render json: {:notifications => @notifications.limit(5), :notifications_count => @notifications.where(:read => false).count}}
    end  
  end
  
  def read
    current_user.notifications.limit(5).each do |notification|
      notification.read = true
      notification.save
    end
  end
end
