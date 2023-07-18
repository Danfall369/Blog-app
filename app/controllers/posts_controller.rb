class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @posts = params[:id]
  end
end
