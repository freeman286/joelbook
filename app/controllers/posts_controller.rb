class PostsController < ApplicationController
  
  def index
    select_posts
  end

  def show
    select_posts
    render action: "index"
  end

  def new
    select_posts
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
    select_posts
    render :action => 'index'
  end

  def create
    select_posts
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
    select_posts
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
    select_posts
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
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end
end
