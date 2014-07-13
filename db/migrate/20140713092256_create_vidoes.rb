class CreateVidoes < ActiveRecord::Migration
  def change
    create_table :videos, :force => true do |t|
      t.text     :body
      t.text     :body_html
      t.integer  :post_id
      t.datetime :created_at,  :null => false
      t.datetime :updated_at,  :null => false
    end
  end
end
