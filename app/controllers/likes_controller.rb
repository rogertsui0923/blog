class LikesController < ApplicationController
  before_action :authenticate_user, only: [:create, :destroy]

  def create
    post = Post.find params[:post_id]
    if current_user == post.user
      redirect_to root_path, alert: 'You can\'t like your own post!'
      return
    end
    like = Like.new(post: post, user: current_user)
    if like.save
      redirect_to root_path, notice: 'Post liked!'
    else
      redirect_to root_path, alert: 'A problem occured!'
    end
  end

  def destroy
    like = Like.find(params[:id])
    if like.destroy
      redirect_to root_path, notice: 'Post un-liked!'
    else
      redirect_to root_path, alert: 'A problem occured!'
    end
  end
end
