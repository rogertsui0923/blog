class CommentsController < ApplicationController
  before_action :authenticate_user
  def create
    comment_params = params.require(:comment).permit(:body)
    @comment = Comment.new comment_params
    @post = Post.find params[:post_id]
    @comment.post = @post
    @comment.user = current_user
    if @comment.save
      CommentsMailer.notify_user(@comment).deliver_later
      redirect_to post_path(params[:post_id]), notice: 'Comment created!'
    else
      flash.now[:alert] = 'Please fix errors!'
      render 'posts/show'
    end
  end

  def destroy
    comment = Comment.find params[:id]
    post = comment.post
    if !can?(:manage, comment)
      redirect_to post_path(post), alert: 'Not authorized!'
      return
    end
    comment.destroy
    redirect_to post_path(post), notice: 'Comment deleted!'
  end
end
