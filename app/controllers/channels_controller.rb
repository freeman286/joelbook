class ChannelsController < ApplicationController
  def new
    @channel = Channel.new
  end

  def create
    @channel = Post.new(params[:channel])
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
    @diagnostic = Diagnostic.find(params[:id])
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
    @channels = Channels.all
  end

  def show
    @channels = Channels.find(params[:id])
  end
end
