class UserFriendshipsController < ApplicationController
	before_filter :authenticate_user!
	respond_to :html, :json
  
  def index
    @user_friendships = current_user.user_friendships
  end
  
  def accept
    @user_friendship = current_user.user_friendships.find(params[:id])
    if @user_friendship.update_attribute(:state, 'accepted') && @user_friendship.accept_mutual_friendship!
      flash[:notice] = "You are now friends with #{@user_friendship.friend.name}"
    else
      flash[:alert] = "That friendship was not accepted"
    end
    redirect_to user_friendships_path
  end
  
  def decline
    @user_friendship = current_user.user_friendships.find(params[:id])
    if @user_friendship.update_attribute(:state, 'declined') && @user_friendship.declined_mutual_friendship!
      flash[:notice] = "You have declined #{@user_friendship.friend.name}"
    else
      flash[:alert] = "That friendship was not declined"
    end
    redirect_to user_friendships_path
  end
  
  def block
    @user_friendship = current_user.user_friendships.find(params[:id])
    friendship = UserFriendship.create!(user: current_user, friend: @user_friendship.friend, state: 'pending')
    friendship.update_attribute(:state, 'blocked')
    redirect_to user_friendships_path
    if @user_friendship.destroy
      flash[:notice] = "You have blocked #{@user_friendship.friend.name}"
    else
      flash[:alert] = "That friendship could not be blocked"
    end
  end
  
  def new
    if params[:friend_id]
      @friend = User.where(profile_name: params[:friend_id]).first
      raise ActiveRecord::RecordNotFound if @friend.nil?
      @user_friendship = current_user.user_friendships.new(friend: @friend)
    else
      flash[:alert] = "Friend required"
    end
  rescue ActiveRecord::RecordNotFound
    render file: 'public/404', status: :not_found
  end

  def create
    if params[:user_friendship] && params[:user_friendship].has_key?(:friend_id)
    @friend = User.where(profile_name: params[:user_friendship][:friend_id]).first
    @user_friendship = UserFriendship.request(current_user, @friend)
    respond_to do |format|
      if @user_friendship.new_record?
        format.html do
        flash[:alert] = "There was a problem creating that friend request"
        redirect_to profile_path(@friend)
      end
        format.json { render json: @user_friendship.to_json, status: :precondition_failed }
      else
        format.html do
          flash[:notice] = "Friend request sent to #{@friend.name}"
          redirect_to profile_path(@friend)
        end
        format.json { render json: @user_friendship.to_json }
      end
    end
    else
      flash[:alert] = "Friend required"
      redirect_to root_path
    end
  end
  
  def edit
    @user_friendship = UserFriendship.where(id: params[:id]).first
    @friend = @user_friendship.friend
  end
  
  def destroy
    @user_friendship = current_user.user_friendships.find(params[:id])
    if !@user_friendship.block
      if @user_friendship.destroy && @user_friendship.delete_mutual_friendship!
        flash[:notice] = "User unblocked"
      else
        flash[:alert] = "User is still blocked"
      end
    else
      if @user_friendship.destroy
        flash[:notice] = "Friendship deleted"
      else
        flash[:alert] = "Friendship failed delete"
      end
    end
    redirect_to user_friendships_path
  end
  
  private
  def friendship_association
    case params[:list]
    when nil
      current_user.user_friendships
    when 'blocked'
      current_user.blocked_user_friendships
    when 'pending'
      current_user.pending_user_friendships
    when 'accepted'
      current_user.accepted_user_friendships
    when 'requested'
      current_user.requested_user_friendships  
    end
  end
end