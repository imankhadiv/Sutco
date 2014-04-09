class AppMailer < ActionMailer::Base
  default from: "sutcogenesys@gmail.com"

  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: 'Status change')
  end

  def show_comment_mail(user_id, board, comment)
    @comment = comment
    @recipients = User.where(id: User.get_production_team_members).pluck(:email) +
        User.where(id: Board.board_users(board)).pluck(:email) - User.where(id: user_id).pluck(:email)
    mail(to: (@recipients.uniq), subject: 'A new comment has been posted on ' + @comment.conversation.title, template_path: 'app_mailer',
         template_name: 'comment_mail')
  end

  def general_comment_mail(user_id, comment)
    @comment = comment
    mail(to: (User.all.pluck(:email) - User.where(id: user_id).pluck(:email)), subject: 'A new comment has been posted on ' + @comment.conversation.title,template_path: 'app_mailer',
         template_name: 'comment_mail')
  end
end
