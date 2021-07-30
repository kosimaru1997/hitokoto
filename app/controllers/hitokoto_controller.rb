class HitokotoController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.set_sentiment_with_title
    @post.set_int_with_personality
    @post.set_bournus
    if @post.save
      redirect_to hitokoto_path(@post)
    else
      flash[:notice] = "ばぶばぶ（３文字以上２０文字以下でちゅよ)"
      render "hitokoto/new"
    end
  end

  def index
    @posts = Post.all.limit(7).order(id: "DESC")
  end

  def show
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:post)
  end
end
