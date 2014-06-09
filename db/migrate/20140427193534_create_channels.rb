class CreateChannels < ActiveRecord::Migration
  def change
    create_table :channels do |t|
      t.string :name
      t.boolean :private
      t.boolean :public
      t.integer :owner_user_id
      t.integer :secondary_owner_user_id
		  t.timestamps
    end
  end
end