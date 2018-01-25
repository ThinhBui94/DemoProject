class FriendshipsController < ApplicationController
  def create
    @user = User.find_by id: params[:id]
    if !Friendship.exists? user_id: current_user.id, friend_id: @user.id
      @new_send_request = Friendship.new user_id: current_user.id,
        friend_id: @user.id, status: "sent"
      @new_receive_request = Friendship.new user_id: @user.id,
        friend_id: current_user.id, status: "received"
      # Nếu chưa có cả 2 bên hiện là Add friend
      if @new_send_request.save && @new_receive_request.save
        @temp = 1 # Đây là tr hợp lần đầu send => 1 bên là sent / 1 bên là new request
      else
        @temp = false # Vẫn hiện là Add friend
      end
    else # 2 tr hợp : accepted và sent
      @friendship = Friendship.find_by user_id: current_user.id, friend_id: @user.id
      @friendship_reverse = Friendship.find_by user_id: @user.id, friend_id: current_user.id

      if @friendship.status == "sent" && @friendship_reverse == "received"
        @friendship.destroy
        @friendship_reverse.destroy
        @temp = 0
      elsif @friendship.status == "accepted" && @friendship_reverse == "accepted"
        @temp = 2
      end
    end
    return @temp

    respond_to do |format|
      format.html {redirect_to user_path(@user)}
      format.js
    end
  end

  def update

  end

  def destroy
  end
end
