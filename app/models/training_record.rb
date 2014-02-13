class TrainingRecord < ActiveRecord::Base
  belongs_to :user
  belongs_to :training
  validates :training, uniqueness: {scope: :user,  message: "You can only apply for one position for a particular show date" }


  def self.create_new_record userID, trainingID
    record = TrainingRecord.create(user_id: userID, training_id: trainingID)
  end

  def self.training_applied userID, trainingID
      TrainingRecord.where(user_id:userID,training_id:trainingID)
  end


end
