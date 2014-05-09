class AddUserImgUrlToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :user_img_url, :string
  end
end
