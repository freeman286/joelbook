class ChannelsController < ApplicationController
  
  def new
    @channel = Channel.new
  end

  def create
    params[:channel].delete :page
    @channel = Channel.new(params[:channel].merge(:owner_user_id => current_user.id))
    @channel.users << current_user
    if @channel.save
      redirect_to channels_path, notice: 'Channel was successfully created.'
    else
      @channels = Channel.all - Channel.select {|c| c.private?}
      render :template => "channels/index"
    end
  end

  def update
    @channel = Channel.find(params[:id])
    
    page =  params[:channel][:page]
    
    params[:channel].delete :page
  
    if @channel.owner_user == current_user && @channel.update_attributes(params[:channel])
      redirect_to url_from_params(page, @channel), notice: 'Channel was successfully updated.'
    else
      @channels = Channel.all - Channel.select {|c| c.private?}
      @alert_align = true
      @image = Image.new
      @posts = @channel.posts
      render :template => template_from_params(page, @channel)
    end
  end

  def edit
    @channel = Channel.find(params[:id])
  end

  def destroy
    @channel = Channel.find(params[:id])
    if @channel.destroy
      redirect_to channels_path, notice: 'Channel was successfully deleted.'
    else                         
      redirect_to channels_path, alert: 'Channel was not deleted.'
    end
  end

  def index
    @channels = current_user.channels
    @channel = Channel.new
    @alert_align = true
  end

  def show
    @channel = Channel.find(params[:id])
    if @channel.includes_user?(current_user)
      redirect_to channel_posts_path(@channel)
    else
      redirect_to channels_path
    end
  end
  
  def search
    @channel = Channel.find(params[:user][:channel_id])
    if params[:user][:name]
      @users = User.search(params[:user][:name], @channel.users)
    end
    respond_to do |format|
      format.js
      format.html
    end
  end
  
  def search_all
    @channels = Channel.search(params[:channel][:name])
    respond_to do |format|
      format.js
      format.html
    end
  end
  
  def add
    @channel = Channel.find(params[:channel_id])
    @user = User.find(params[:id])
    respond_to do |format|
      if @channel.users.include?(@user) || !@channel.current_user_valid
        @valid = false
        format.js
      else
        @valid = true  
        if @channel.users << @user
          Notification.create(
            :owner_user_id => @user.id,
            :secondary_owner_user_id => current_user.id,
            :resource_type => "Channel",
            :resource_id => @channel.id,
            :content => "#{current_user.name} has added you to channel #{@channel.name}",
            :read => false
          )
          format.js
          format.json { render json: @channel.to_json }
        else
          format.json { render json: @channel.errors, status: :unprocessable_entity }
        end
      end
    end
  end
  
  def remove
    @channel = Channel.find(params[:channel_id])
    @user = User.find(params[:id])
    respond_to do |format|
      if !@channel.users.include?(@user) || !@channel.current_user_valid
        @valid = false
        format.js
      else  
        @valid = true
        if @channel.users.delete(@user)
          Notification.create(
            :owner_user_id => @user.id,
            :secondary_owner_user_id => current_user.id,
            :resource_type => "Channel",
            :resource_id => @channel.id,
            :content => "#{current_user.name} has removed you from channel #{@channel.name}",
            :read => false
          )
          format.js
          format.json { render json: @channel.to_json }
        else
          format.json { render json: @channel.errors, status: :unprocessable_entity }
        end
      end
    end
  end
  
  def add_private
    if !User.find(params[:user_id]).can_be_messaged
      redirect_to root_path, alert: 'That user does not want to be messaged.'
    else
      @channel = Channel.new(:owner_user_id => params[:id], :secondary_owner_user_id => params[:user_id], :private => true, :name => "Private conversation between #{User.find(params[:id]).name} and #{User.find(params[:user_id]).name}")
      @channel.users << User.find(params[:id])
      @channel.users << User.find(params[:user_id])
      @channel.save
      redirect_to channel_posts_path(@channel)
    end
  end
  
  private
  
  def template_from_params(params, channel)
    if params == "posts"
      "posts/index"
    else
      "channels/index"
    end
  end
  
  def url_from_params(params, channel)
    if params == "posts"
      channel_posts_path(channel)
    else
      channels_path
    end
  end
end
