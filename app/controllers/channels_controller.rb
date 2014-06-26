class ChannelsController < ApplicationController
  
  def new
    @channel = Channel.new
  end

  def create
    @channel = Channel.new(params[:channel].merge(:owner_user_id => current_user.id))
    @channel.users << current_user
    if @channel.save
      redirect_to channels_path, notice: 'Channel was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @channel = Channel.find(params[:id])
  
    if @channel.owner_user == current_user && @channel.update_attributes(params[:channel])
      redirect_to channel_path(@channel), notice: 'Channel was successfully updated.'
    else
      render action: "edit"
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
    @channels = Channel.all
  end

  def show
    @channel = Channel.find(params[:id])
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
    if params[:channel][:name]
      @channels = Channel.search(params[:channel][:name])
    end
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
          format.js
          format.json { render json: @channel.to_json }
        else
          format.json { render json: @channel.errors, status: :unprocessable_entity }
        end
      end
    end
  end
  
  def add_private
    @channel = Channel.new(:owner_user_id => params[:id], :secondary_owner_user_id => params[:user_id], :private => true, :name => "Private conversation between #{User.find(params[:id]).name} and #{User.find(params[:user_id]).name}")
    @channel.users << User.find(params[:id])
    @channel.users << User.find(params[:user_id])
    @channel.save
    redirect_to channel_posts_path(@channel)
  end
end
