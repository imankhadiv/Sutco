class WorkshopRecord < ActiveRecord::Base
  belongs_to :user
  belongs_to :workshop

  def self.create_new_record user_id, workshop_id
    record = WorkshopRecord.create(user_id: user_id, workshop_id: workshop_id)
  end

  def self.workshop_applied user_id, workshop_id
    WorkshopRecord.where(user_id: user_id, workshop_id: workshop_id)
  end


end
