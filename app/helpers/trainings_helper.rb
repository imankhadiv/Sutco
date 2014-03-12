module TrainingsHelper

  def check_training_attendee(training)
    if(TrainingRecord.training_applied current_user.id, training.id).empty?
       link_to "Attend Training", attend_training_path, training.date < Time.now
    else
      "You have registered for #{training.title}"
    end
  end

  def training_navigation_links(training)
    content_tag :h3 do
      if ((current_user.role? "SeniorCommittee") || (current_user.role? "TechManager"))
        [
            link_to('<i class="icon-circle-arrow-left"></i> Back'.html_safe,trainings_path),
            "|",
            link_to('<i class="icon-edit-sign"></i> Edit'.html_safe,edit_training_path(training))  ,
            "|"                                                        ,
            link_to('<i class="icon-trash"></i> Delete'.html_safe,training, :method => :delete, :data => { :confirm => 'Are you sure?'})
        ].join(' ').html_safe
      else
        [link_to('<i class="icon-circle-arrow-left"></i> Back'.html_safe,trainings_path)].join(' ').html_safe
      end
    end
  end

 end
