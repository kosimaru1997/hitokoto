class HitokotoController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    post = Post.new(post_params)
    sentiment = post.get_sentiment
    post.score = sentiment[:score]
    post.magnitude = sentiment[:magnitude]
    post.random_int1 = rand(rand(200))
    post.random_int2 = rand(rand(200))
    if post.save
      redirect_to hitokoto_path(post)
    else
      redirect_to new
    end
  end

  def index
  end

  def show
  end

  def post_params
    params.require(:post).permit(:post)
  end
end
