class LikesController < ApplicationController
    def create
      @post = Post.find(params[:post_id])
      @like = @post.likes.build(user: current_user)
      if @like.save
        redirect_to user_post_path(current_user, @post), notice: 'Like agregado exitosamente.'
      else
        redirect_to user_post_path(current_user, @post), alert: 'Error al agregar el like.'
      end
    end
  
    def destroy
      @like = Like.find(params[:id])
      @like.destroy
      redirect_to user_post_path(current_user, @like.post), notice: 'Like eliminado exitosamente.'
    end
  end
  