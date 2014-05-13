class UsersController < ApplicationController
  def update
    @user = User.find(params[:id])

    if @user.update_attributes(params[:user])
      redirect_to root_path, notice: 'Avatar was successfully cropped.'
    else
      redirect_to root_path alert: 'Avatar was failed to crop.'
    end
  end
end