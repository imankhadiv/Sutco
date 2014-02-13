class TrainingRecord < ActiveRecord::Base
  belongs_to :user
  belongs_to :training
  validates :training, uniqueness: {scope: :user,  message: "You can only apply for one position for a particular show date" }


  def self.create_new_record user_id, training_id
    record = TrainingRecord.create(user_id: user_id, training_id: training_id)
  end

  def self.training_applied user_id, training_id
      TrainingRecord.where(user_id:user_id,training_id:training_id)
  end

  def self.get training_id
    user_ids = Array.new
    records = TrainingRecord.where training_id:training_id
    records.each do |v|
      user_ids << v.user_id
    end
    user_ids
  end

end
