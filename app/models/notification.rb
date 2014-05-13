class Notification < ActiveRecord::Base
  belongs_to :comment
  belongs_to :user
  belongs_to :conversation

  def self.remove_notification user_id, conversation_id
    Notification.where(user_id: user_id, conversation_id: conversation_id).destroy_all
  end

  def self.check_notification user_id
    Notification.where(user_id: user_id)
  end

  def self.get_number_of_notifications user_id
    (self.check_notification user_id).size
  end


end
