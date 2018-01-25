class CommentsController < ApplicationController
  before_action :set_post
  before_action :correct_user, only: :destroy
  before_action :authenticate_user!, except: :show

  def index
    @comments = Comment.order_by_date_created
  end

  def show
    @comment = Comment.find_by id: params[:id]
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = @post.comments.build comment_params
    @comment.user_id = current_user.id

    if @comment.save
      respond_to do |format|
        format.html do
          flash[:info] = t :success
          redirect_to @post
        end
        format.js
      end
    else
      flash[:info] = t :comment_false
    end
  end

  def destroy
    @comment = Comment.find_by id: params[:id]
    @comment.destroy
    respond_to do |format|
      format.html do
        flash[:success] = t :comment_delete
        redirect_to @post
      end
      format.js
    end
  end

  private

  def comment_params
    params.require(:comment).permit :content, :post_id, :date_created
  end

  def correct_user
    @comment = current_user.comments.find_by id: params[:id]
    redirect_to root_url if @comment.nil?
  end

  def set_post
    @post = Post.find_by id: params[:post_id]
    return if @post
    redirect_to root_url
  end
end
