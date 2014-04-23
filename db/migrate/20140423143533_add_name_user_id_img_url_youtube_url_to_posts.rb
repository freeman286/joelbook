class AddNameUserIdImgUrlYoutubeUrlToPosts < ActiveRecord::Migration
  def change
    remove_column :posts, :user
	remove_column :posts, :title
    add_column :posts, :name, :string
    add_column :posts, :user_id, :integer
	add_column :posts, :img_url, :string
	add_column :posts, :youtube_url, :string
  end
end
