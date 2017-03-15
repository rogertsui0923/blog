class CommentsMailer < ApplicationMailer
  def notify_user(comment)
    @comment = comment
    @post = comment.post
    @user = @post.user
    mail(to: @user.email, subject: "New comment on your post #{@post.title}")
  end
end
