class HomeController < ApplicationController
  def index
    @posts = Post.all.select{|p| p.channel.public?}
  end
end