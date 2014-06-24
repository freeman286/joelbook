class AddOriginalImageUrlToImages < ActiveRecord::Migration
  def change
    add_column :images, :original_image_url, :string
  end
end
