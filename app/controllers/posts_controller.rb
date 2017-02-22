class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new strong_params
    # temporary before implement drop dropdown
    @post.category = Category.last
    if @post.save
      redirect_to post_path(@post)
    else
      render 'new'
    end
  end

  def show
    @post = Post.find params[:id]
    @comment = Comment.new
    @category = Category.find @post.category_id
  end

  def edit

  end

  def update

  end

  def destroy

  end

  private

  def strong_params
    params.require(:post).permit(:title, :body)
  end
end
