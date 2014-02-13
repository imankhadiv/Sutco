module TrainingsHelper

  def check_training_attendee(training)
    if(TrainingRecord.training_applied current_user.id, training.id).empty?
       link_to "Attend Training", attend_training_path
    else
     # flash[:notice] = "You have already registered for #{training.title}" unless flash[:notice]
     # flash.discard

      "You have registered for #{training.title}"
    end
  end
end
