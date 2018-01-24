module UsersHelper
  def current_user? user
    user == current_user
  end

  def post_owner?
    @user == current_user
  end
end
