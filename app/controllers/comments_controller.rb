class CommentsController < ApplicationController
  before_action :find_user_and_post, only: %i[new create]

  def new
    @comment = Comment.new
  end

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to user_post_path(@user, @post), notice: 'Comment saved successfully.'
    else
      flash.now[:alert] = 'Error: Comment could not be saved'
      render :new
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end

  def find_user_and_post
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
  end
end
