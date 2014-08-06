class AddActedOnToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :acted_on, :boolean, :default => false
  end
end
