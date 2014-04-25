class AddNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    User.reset_column_information
    add_index :users, :name, :unique => true
  end
end