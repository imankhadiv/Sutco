class Comment < ActiveRecord::Base
  #attr_accessor:current_user_
  belongs_to :user
  belongs_to :conversation
  validates :body, presence: true
  #after_save :notify_users



  def notify_users

    users = User.ids - [user_id]
    users.each do |u|
        Notification.create(user_id:u,comment_id:id, conversation_id:conversation_id)

    end

  end

end
