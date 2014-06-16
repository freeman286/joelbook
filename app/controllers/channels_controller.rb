class ChannelsController < ApplicationController
  def new
    @channel = Channel.new
  end

  def create
    @channel = Channel.new(params[:channel].merge(:owner_user_id => current_user.id))
    @channel.users << current_user
    if @channel.save
      redirect_to channel_path(@channel), notice: 'Channel was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @channel = Channel.find(params[:id])
  
    if @channel.update_attributes(params[:channel].merge(:owner_user_id => current_user.id))
      @diagnostic.make_wheel()
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
      @users = User.search(params[:user][:name])
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
      if @channel.users.include?(@user)
        @new = false
        format.js
      else
        @new = true  
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
      if @channel.users.delete(@user)
        format.js
        format.json { render json: @channel.to_json }
      else
        format.json { render json: @channel.errors, status: :unprocessable_entity }
      end
    end
  end
end
