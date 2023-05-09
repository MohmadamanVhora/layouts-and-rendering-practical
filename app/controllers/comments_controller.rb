class CommentsController < ApplicationController
  before_action :find_comment, only: %i[edit update destroy]
  before_action :find_post, only: %i[index new create edit update destroy]
  before_action :check_user, only: %i[edit destroy]

  def index
    @comments = @post.comments
  end
  
  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      respond_to do |format|
        format.html { redirect_to post_comments_path(@post) }
        format.turbo_stream
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @comment.update(comment_params)
      respond_to do |format|
        format.html { redirect_to post_comments_path(@post) }
        format.turbo_stream
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to post_comments_path(@post) }
      format.turbo_stream
    end
  end
  
  private

  def find_comment
    @comment = Comment.find(params[:id])
  end

  def find_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:comment, :post_id, :user_id)    
  end

  def check_user
    if @comment.user != current_user
      flash[:alert] = "You can not edit this comment"
      redirect_to posts_path
    end
  end
end
