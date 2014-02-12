class TrainingRecord < ActiveRecord::Base
  belongs_to :user
  belongs_to :training

  def self.create_new_record userID, trainingID

    record = TrainingRecord.create(user_id: userID, training_id: trainingID)

  end


end
