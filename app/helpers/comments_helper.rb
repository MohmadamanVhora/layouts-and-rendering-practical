module CommentsHelper
  def user_authenticate(comment)
    comment.user_id == current_user.id
  end
end
