class PostsController < ApplicationController
  helper_method :current_user

  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:user, comments: :user)
  end

  def show
    @post = Post.find(params[:id])
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to user_posts_path(current_user), notice: 'Post saved successfully'
    else
      flash.now[:alert] = 'Error: Post could not be saved'
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
