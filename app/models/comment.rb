class Comment < ActiveRecord::Base
  #attr_accessor:current_user_
  belongs_to :user
  belongs_to :conversation
  validates :body, presence: true
  #after_save :notify_users_for_show



  def notify_users

    users = User.ids - [user_id]
    users.each do |u|
        Notification.create(user_id:u,comment_id:id, conversation_id:conversation_id)

    end

  end
  def notify_users_for_show
    role_applications = RoleApplication.where(status:'Approved')
    role_applications.each do |app|
      Notification.create(user_id:app.user_id,comment_id:id,conversation_id:conversation_id) if app.id != user_id
    end
  end

end
