class PostsController < ApplicationController
  helper_method :current_user

  def index
    @user = current_user
    @posts = Post.all
    @comments = Comment.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def current_user
    @current_user ||= User.first
  end

  def new
    @post = Post.new
  end

  def create
    @post = User.find(params[:user_id]).posts.build(post_params)
    if @post.save
      redirect_to user_posts_path(current_user), notice: 'Post creado exitosamente.'
    else
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
