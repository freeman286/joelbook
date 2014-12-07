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
    @posts = @user.posts.select{|p| p.channel.public?}.last(5)
  end

  def images
    @user = User.find(params[:id])
    if (!current_user.accepted_friends.include?(@user) && @user.images_visable) || (current_user.accepted_friends.include?(@user) && @user.images_visable_to_friends) || current_user == @user
      @images = @user.images.select{|i| !i.private? || i.post.channel.includes_user?(current_user) }
    else
      redirect_to root_path, alert: 'That user does not want to share their photos.'
    end
  end

  def friends
    @user = User.find(params[:id])
    if (!current_user.accepted_friends.include?(@user) && @user.friends_visable) || (current_user.accepted_friends.include?(@user) && @user.friends_visable_to_friends) || current_user == @user
      @friends = @user.accepted_friends
    else
      redirect_to root_path, alert: 'That user does not want to share their friends.'
    end
  end

  def visible_links
    @user = User.find(params[:id])
    render partial: 'visible_links'
  end
end
