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
      format.json { render json: {:notifications_to_string => render_to_string(:partial => 'notifications/dropdown_header', :formats=>[:html], locals: { :notifications => @notifications[-5..-1] }).gsub("\n",''), :notifications_count => @notifications.where(:read => false).count}}
    end  
  end
  
  def read
    current_user.notifications[-5..-1].each do |notification|
      notification.read = true
      notification.save
    end
  end
end
