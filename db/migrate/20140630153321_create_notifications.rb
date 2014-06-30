class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :owner_user_id
      t.integer :secondary_owner_user_id
      t.string :resource_type
      t.integer :resource_id
      t.string :content
      t.boolean :read
      
      t.timestamps
    end
  end
end
