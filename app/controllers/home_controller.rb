class HomeController < ApplicationController
  def index
    @posts = Post.all.select{|p| p.channel.public?}
    @events = Event.all.pop(5)
  end
end