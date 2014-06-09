class ChannelsController < ApplicationController
  def new
    @channel = Channel.new
  end

  def create
    @channel = Channel.new(params[:channel].merge(:owner_user_id => current_user.id))
    if @channel.save
      redirect_to channel_path(@channel), notice: 'Channel was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @channel = Channel.find(params[:id])
  
    if @channel.update_attributes(params[:channel])
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
    @posts = @channel.posts
  end
end
