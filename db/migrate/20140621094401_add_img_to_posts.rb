class AddImgToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :img_uid,  :string
    add_column :posts, :img_name, :string
  end
end
