module WorkshopsHelper
  def check_workshop_attendee(workshop)
    if(WorkshopRecord.workshop_applied current_user.id, workshop.id).empty?
      link_to "Attend Workshop", attend_workshop_path
    else
      "You have registered for #{workshop.title}"
    end
  end

end
