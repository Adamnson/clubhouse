class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_body)

    if @post.save
      redirect_to root_path
      # alert "Your post was successful"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_body)
      redirect_to @post
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def show
    # will have to fetch the posts of the user
    @post = Post.find(params[:id])
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    redirect_to root_path, status: :see_other
  end

  private
    def post_body
      params.require(:post).permit(:body)
    end
end
