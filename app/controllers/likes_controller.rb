class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find_by(id: params[:id])
    if @post
      if current_user_can_like?
        @post.increment!(:likes_counter)
      else
        flash[:alert] = 'You are not allowed to like this post.'
      end
    else
      flash[:alert] = 'Post not found.'
    end
    redirect_to user_post_path(@post&.author_id, @post&.id)
  end

  private

  def current_user_can_like?
    # Implement your own authorization logic here.
    !@post.liked_by?(current_user)
  end
end
