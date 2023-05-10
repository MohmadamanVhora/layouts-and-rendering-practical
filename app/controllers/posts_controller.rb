class PostsController < ApplicationController
  before_action :find_post, only: %i[edit update destroy like dislike]
  before_action :check_user, only: %i[edit destroy]

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      respond_to do |format|
        format.html { redirect_to posts_path }
        format.turbo_stream
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @post.update(post_params)
      respond_to do |format|
        format.html { redirect_to posts_path }
        format.turbo_stream
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_path }
      format.turbo_stream
    end
  end
  
  def like
    @post.likes.create(user_id: current_user.id)
    respond_to do |format|
      format.html { redirect_to posts_path }
      format.turbo_stream { render turbo_stream: turbo_stream.replace(@post) }
    end
  end
  
  def dislike
    @post.likes.find_by(user_id: current_user.id).destroy
    respond_to do |format|
      format.html { redirect_to posts_path }
      format.turbo_stream { render turbo_stream: turbo_stream.replace(@post) }
    end
  end

  private

  def find_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :description, :user_id)
  end

  def check_user
    if @post.user != current_user
      flash[:alert] = "You can not edit this post"
      redirect_to posts_path
    end
  end
end
