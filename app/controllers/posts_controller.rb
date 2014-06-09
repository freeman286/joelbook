class PostsController < ApplicationController
  before_filter :select_posts
  
  def index
    respond_to do |format|
      format.html # index.html.erb
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

    respond_to do |format|
      if @post.save
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
      format.html { redirect_to posts_url }
      format.json { render json: @post }
    end

    rescue ActiveRecord::RecordNotFound
  end

  private

  def select_posts
    @posts = Post.all
  end
end
