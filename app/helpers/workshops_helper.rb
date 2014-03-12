module WorkshopsHelper

  def check_workshop_attendee(workshop)
    if(WorkshopRecord.workshop_applied current_user.id, workshop.id).empty?
      link_to "Attend Workshop", attend_workshop_path if workshop.date < Time.now
    else
      "You have registered for #{workshop.title}"
    end
  end

  def workshop_navigation_links(workshop)
    content_tag :h3 do
      if ((current_user.role? "SeniorCommittee") || (current_user.role? "TechManager"))
        [
            link_to('<i class="icon-circle-arrow-left"></i> Back'.html_safe,workshops_path),
            "|",
            link_to('<i class="icon-edit-sign"></i> Edit'.html_safe,edit_workshop_path(workshop))  ,
            "|"                                                        ,
            link_to('<i class="icon-trash"></i> Delete'.html_safe,workshop, :method => :delete, :data => { :confirm => 'Are you sure?'})
        ].join(' ').html_safe
      else
        [link_to('<i class="icon-circle-arrow-left"></i> Back'.html_safe,workshops_path)].join(' ').html_safe
      end
    end
  end

end
