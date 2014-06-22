class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :image_uid
      t.string :image_name
      t.integer :user_id
      t.integer :post_id
      
      t.timestamps
    end
  end
end
