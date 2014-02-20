class WorkshopRecord < ActiveRecord::Base
  belongs_to :user
  belongs_to :workshop

  def self.create_new_record user_id, workshop_id
    record = WorkshopRecord.create(user_id: user_id, workshop_id: workshop_id)
  end

  def self.workshop_applied user_id, workshop_id
    WorkshopRecord.where(user_id:user_id,workshop_id:workshop_id)
  end

  def self.update_workshop_record attended_ids,unattended_ids,temp_ids

    WorkshopRecord.where(id:unattended_ids).update_all(attended:true)

    temp = (temp_ids - attended_ids.to_a) if temp_ids

    WorkshopRecord.where(id:temp).update_all(attended:false)

  end

end
