class UsersController < ApplicationController
  def auth
    @users = User.all
    respond_to do |format|
      format.json {render json: @users.map { |user| user.as_json(:only => :name, :methods => :auth) }}
    end
  end
end