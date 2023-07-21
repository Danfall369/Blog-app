class CommentsController < ApplicationController
    def create
        @post = Post.find(params[:post_id])
        @comment = @post.comments.build(comment_params)
        @comment.user = current_user
        if @comment.save
          redirect_to user_post_path(current_user, @post), notice: 'Comentario creado exitosamente.'
        else
          render :new
        end
    end
    
    private
    
    def comment_params
        params.require(:comment).permit(:text)
    end
end
