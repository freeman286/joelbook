class HomeController < ApplicationController
  def index
    @posts = Post.all.select{|p| p.channel.public?}.last(10)
    @events = Event.all.pop(2)
  end
end