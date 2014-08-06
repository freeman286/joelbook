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
  
  def accept
    @notification = Notification.find(params[:id])
    @notification.update_attribute(:acted_on, true)
    if @notification.resource_type == "UserFriendship"
      @user_friendship = @notification.resource
      @user_friendship.update_attribute(:state, 'accepted') && @user_friendship.accept_mutual_friendship!
    end
  end
  
  def deny
    @notification = Notification.find(params[:id])
    @notification.update_attribute(:acted_on, true)
    if @notification.resource_type == "UserFriendship"
      @user_friendship = @notification.resource
      @user_friendship.update_attribute(:state, 'ignored')
      @user_friendship.decline_mutual_friendship!
    elsif @notification.resource_type == "Channel"
      @channel = @notification.resource
      @channel.users.delete(current_user)
    end
  end
end
