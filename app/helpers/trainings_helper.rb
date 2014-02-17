module TrainingsHelper

  def check_training_attendee(training)
    if(TrainingRecord.training_applied current_user.id, training.id).empty?
       link_to "Attend Training", attend_training_path
    else
      "You have registered for #{training.title}"
    end
  end

 end
