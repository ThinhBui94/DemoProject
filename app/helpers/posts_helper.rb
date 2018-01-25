module PostsHelper
  def like? post
    current_user.like_posts.find_by(post_id: post)
  end
end
