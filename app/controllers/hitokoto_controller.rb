class HitokotoController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    post = Post.new(post_params)
    post.set_sentiment_with_title
    # post.magnitude = sentiment[:magnitude]
    post.set_int_with_personality
    if post.save
      redirect_to hitokoto_path(post)
    else
      redirect_to new
    end
  end

  def index
  end

  def show
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:post)
  end
end
