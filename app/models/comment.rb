class Comment < ActiveRecord::Base
  #attr_accessor:current_user_
  belongs_to :user
  belongs_to :conversation
  validates :body, presence: true
  has_many :notifications, dependent: :destroy


  # this method checks if the message board is public it notified everybody in the system except the current user.
  def notify_users
    board = Conversation.find(conversation_id).board
    if(board.public)
    users = User.ids - [user_id]
    users.each do |u|
        Notification.create(user_id:u,comment_id:id, conversation_id:conversation_id)
    end
    else #if the board is not public, Notifications are sent to the specific people.
      role_applications = RoleApplication.where(status:'Approved')
      role_applications.each do |app|
        Notification.create(user_id:app.user_id,comment_id:id,conversation_id:conversation_id) if app.user_id != user_id
        notify_production_team
      end
    end
  end

  # sending new email for new comments
  def send_mail
    board = Conversation.find(conversation_id).board
    if(!board.public)
      AppMailer.show_comment_mail(user_id, board, self).deliver
    else
      AppMailer.general_comment_mail(user_id, self).deliver
    end
  end

  private
  def notify_production_team
    members = (User.get_production_team_members)-[user_id]
    #members = member-[user_id]
    members.each do |member|
      Notification.create(user_id:member,comment_id:id,conversation_id:conversation_id)
    end

  end

end
