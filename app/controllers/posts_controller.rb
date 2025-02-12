class PostsController < ApplicationController
  before_action :authenticate_user!, except: %i[index]
  def index
    @posts = Post.all
  end

  def new
    @user = User.find(params[:user_id])
    @post = Post.new
  end

  def create
    @post = Post.new(post_body)
    @post.user = current_user

    if @post.save
      redirect_to root_path
      # alert "Your post was successful"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.user = current_user

    if @post.update(post_body)
      redirect_to root_path
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
