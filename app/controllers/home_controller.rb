class HomeController < ApplicationController
  def index
    @posts = Post.all.select{|p| p.channel.public?}
    @events = Event.all.pop(2)
  end
end