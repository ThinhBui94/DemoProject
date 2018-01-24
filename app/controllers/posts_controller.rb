class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update]
  def index
    @posts = Post.all.page(params[:page]).per(10)
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build post_params
    @post.user = current_user

    if @post.save
      flash.now[:success] = t :event_created
      redirect_to @post
    else
      flash[:danger] = @post.errors.full_messages
      redirect_to new_post_path
    end
  end

  def show
  end

  def edit
  end

  def update
    if @post.update_attributes post_params
      redirect_to @post
    else
      flash[:danger] = t :update_false
      render :edit
    end
  end

  private

  def find_post
    @post = Post.find_by id: params[:id]
    if @post.nil?
      flash[:danger] = t :error
      redirect_to root_url
    end
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
