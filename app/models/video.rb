class Video < ActiveRecord::Base
  belongs_to :post
  
  attr_accessible :body, :body_html, :post_id

  auto_html_for :body do
    html_escape
    image
    youtube(:width => 400, :height => 250)
    link :target => "_blank", :rel => "nofollow"
    simple_format
  end
end