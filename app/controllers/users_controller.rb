class UsersController < ApplicationController
  before_action :find_user, only: [:show, :edit, :update, :post_owner?]

  def show
    @created_posts = @user.posts
  end

  def edit
  end

  def update
    if @user.update_attributes edit_user_params
      flash[:success] = t ".profile_updated"
      redirect_to new_user_session_path
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit :email, :password,
      :password_confirmation
  end

  def edit_user_params
    params.require(:user).permit :email, :password,
      :password_confirmation
  end

  def find_user
    @user = User.find_by id: params[:id]
    return if @user
    redirect_to root_path
  end
end
