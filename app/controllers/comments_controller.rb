class CommentsController < ApplicationController
  def index

  end

  def new

  end

  def create
    comment_params = params.require(:comment).permit(:body)
    @comment = Comment.new comment_params
    @post = Post.find params[:post_id]
    @comment.post = @post
    if @comment.save
      redirect_to post_path(params[:post_id])
    else
      render 'post/show'
    end
  end

  def edit

  end

  def show

  end

  def update

  end

  def destroy

  end

end
