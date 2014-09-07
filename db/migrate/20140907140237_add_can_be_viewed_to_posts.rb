class AddCanBeViewedToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :can_be_viewed, :boolean, :default => false
  end
end
