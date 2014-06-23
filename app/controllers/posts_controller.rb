class PostsController < ApplicationController
  before_filter :select_posts
  
  def index
    respond_to do |format|
      format.html {
        if params[:channel_id]
          @channel = Channel.find(params[:channel_id])
          @image = Image.new
          if @channel.includes_user?(current_user)
            @posts = @channel.posts
          else
            redirect_to root_path, alert: "You are not a member of that channel"
          end
        else
          @posts = Post.all
        end
      }
      format.json { render json: @posts }
    end
  end

  def show
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
    render action: "index"
  end

  def new
    @post = Post.new
    respond_to do |format|
      format.html {
            @posts = Post.all
            render :action => 'index'
      }
      format.json { render json: @post }
    end
  end

  def edit
    @post = Post.find(params[:id])
    render :action => 'index'
  end

  def create
    @post = Post.new(params[:post])
    @image = Image.select{|i| i.image.url == params[:post][:img_url]}.first
    puts @image.class
    @image.post = @post
    @image.user = User.find(params[:post][:user_id])
    
    respond_to do |format|
      if @post.save && @image.save
        format.html { redirect_to @post, notice: 'post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post, notice: 'post was successfully updated.' }
        format.json { render json: @post }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to channel_path(@channel) }
      format.json { render json: @post }
    end

    rescue ActiveRecord::RecordNotFound
  end
  
  def upload
    respond_to do |format|
      format.js
      format.html
    end
  end
  
  private

  def select_posts
    @posts = Post.all
  end
end
