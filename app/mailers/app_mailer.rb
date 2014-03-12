class AppMailer < ActionMailer::Base
  default to: Proc.new { User.pluck(:email)},
          from: "sutcogenesys@gmail.com"
  def welcome_email(user)
    @user = user
    @url  = 'http://localhost:3000'
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end

  def comment_mail(user_id, board)
    @url  = 'http://localhost:3000'
    mail(to: (User.where(id: Board.board_users(board)).pluck(:email) - User.where(id: user_id).pluck(:email)), subject: 'Welcome to My Awesome Site')
  end
end
