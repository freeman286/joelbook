class AddDragonflyCroppingToUsers < ActiveRecord::Migration
  def change
    add_column :users, :avatar_width, :integer
    add_column :users, :avatar_height, :integer
    add_column :users, :avatar_cropping, :string
  end
end