class TrainingRecord < ActiveRecord::Base
  belongs_to :user
  belongs_to :training

  def self.create_new_record user_id, training_id
    record = TrainingRecord.create(user_id: user_id, training_id: training_id)
  end

  def self.training_applied user_id, training_id
      TrainingRecord.where(user_id:user_id,training_id:training_id)
  end

  def self.update_training_record attended_ids,unattended_ids,temp_ids

    TrainingRecord.where(id:unattended_ids).update_all(attended:true)

    temp = (temp_ids - attended_ids.to_a) if temp_ids

    TrainingRecord.where(id:temp).update_all(attended:false)

  end



end
