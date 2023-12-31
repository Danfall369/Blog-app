class CommentsController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
    @comment = Comment.new
    @all_comments = @post.comments
  end

  def create
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to user_post_path(@user, @post), notice: 'Comment save successfully.'
    else
      render :new, alert: 'Error: Comment could not be saved'
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])

    if @comment.destroy
      redirect_to user_post_path(@user, @post), notice: 'Comment deleted successfully.'
    else
      redirect_to user_post_path(@user, @post), alert: 'Error: Comment could not be deleted.'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
