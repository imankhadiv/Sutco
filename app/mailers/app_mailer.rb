class AppMailer < ActionMailer::Base
  default to: Proc.new { User.pluck(:email) },
          from: "sutcogenesys@gmail.com"

  def welcome_email(user)
    @user = user
    @url = 'http://localhost:3000'
    mail(to: @user.email, subject: 'Status change')
  end

  def comment_mail(user_id, board, comment)
    @url = 'http://localhost:3000'
    @comment = comment

    @recipients = User.where(id: User.get_production_team_members).pluck(:email) +
        User.where(id: Board.board_users(board)).pluck(:email) - User.where(id: user_id).pluck(:email)
    mail(to: (@recipients.uniq), subject: 'New Comment')
  end

  def general_comment(user_id, comment)
    @comment = comment
    mail(to: (User.all.pluck(:email) - User.where(id: user_id).pluck(:email)), subject: 'New Comment')
  end
end
