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
    @users = User.search(params[:user][:name])
    respond_to do |format|
      format.js
      format.html
    end
  end
  
  def show
    @user = User.find(params[:id])
  end
end