module PostsHelper
  def post_liked(post)
    post.likes.where(user_id: current_user.id).present?
  end

  def user_authenticate(post)
    post.user_id == current_user.id
  end
end
