class UsersController < ApplicationController
  def update
    @user = User.find(params[:id])
        
    if @user.update_attributes(params[:user])
      redirect_to root_path, notice: 'Avatar was successfully cropped.'
    else
      redirect_to root_path alert: 'Avatar was failed to crop.'
    end
  end
  
  def search
    if params[:user][:name]
      @users = User.search(params[:user][:name])
    end
    respond_to do |format|
      format.js
      format.html
    end
  end
  
  def show
    @user = User.find(params[:id])
    @channel = Channel.find_private_channel(@user, current_user)
    @posts = @user.posts
  end
  
  def images
    @user = User.find(params[:id])
    @images = @user.images.select{|i| !i.private? || i.post.channel.includes_user?(current_user) }
  end
end