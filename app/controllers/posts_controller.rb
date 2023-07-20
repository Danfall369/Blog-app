class PostsController < ApplicationController
  def index
    @user = current_user
    @posts = Post.all
    @comments = Comment.all
  end

  def show
    @post = Post.find(params[:id])
  end
end
