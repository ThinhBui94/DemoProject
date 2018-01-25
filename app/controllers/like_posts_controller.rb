class LikePostsController < ApplicationController
  before_action :logged_in?, only: [:create]
  def create
    @user = current_user.id
    @post = params[:post_id]
    @current_post = Post.find_by id: @post
    @new_like = LikePost.new user_id: @user, post_id: @post

    if @new_like.save
      @temp = true
    else
      @new_like = LikePost.find_by user_id: @user, post_id: @post
      @new_like.destroy
      @temp = false
    end
    return @temp

    respond_to do |format|
      format.html {redirect_to post_path(@current_post)}
      format.js
    end
  end

  private

  def logged_in?
    return if current_user.present?
    redirect_to new_user_path
  end
end
