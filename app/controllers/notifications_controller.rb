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
      format.json { render json: {
        :notifications_count => @notifications.where(:read => false).count,
        :index_notifications_to_string => render_to_string(:partial => 'notifications/notifications', :formats=>[:html], locals: { :notifications => @notifications }).gsub("\n",''),
        :notifications_to_string => render_to_string(:partial => 'notifications/dropdown_header', :formats=>[:html], locals: { :notifications => @notifications.pop(5) }).gsub("\n",'')
      }}
    end  
  end
  
  def read
    current_user.notifications.each do |notification|
      notification.read = true
      notification.save
    end
  end
end
