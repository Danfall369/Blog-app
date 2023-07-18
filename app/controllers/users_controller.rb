class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @users = params[:id]
  end
end
