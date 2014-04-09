module TrainingsHelper
  def training_name_links(training)
    content_tag :h3 do
    if ((current_user.role? "SeniorCommittee") || (current_user.role? "TechManager"))
      [
        link_to_button('buttonshowname',training.title,training),
        link_to_button('buttonedit','Edit', edit_training_path(training)),
        link_to_button('buttondelete','Delete', training, {
          data: {confirm: 'Are you sure?'},
          method: :delete
      })
      ].join(' ').html_safe
    else
      [ link_to(training.title,training)
      ].join(' ').html_safe
    end
    end
  end

  def check_training_attendee(training)
    if(TrainingRecord.training_applied current_user.id, training.id).empty?
       link_to "Attend Training", attend_training_path if training.date >= Date.today
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
