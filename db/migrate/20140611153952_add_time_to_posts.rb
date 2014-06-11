class AddTimeToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :time, :integer
  end
end
