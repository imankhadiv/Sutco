#
# workshops_helper.rb
#
# This is an helper class for Workshops.
# It contains a method for displaying navigation links based on the current logged in user.
# It also provides custom display methods for workshops and can check a current user's attendance for an event
#
module WorkshopsHelper

# This method is implemented to display the workshop name and three different icons for view, edit and delete buttons.
  def workshop_name_links(workshop)
    content_tag :h3 do
    if ((current_user.role? "SeniorCommittee") || (current_user.role? "TechManager"))
      [
        link_to_button('buttonshowname',workshop.title,workshop),
        link_to_button('buttonedit','Edit', edit_workshop_path(workshop)),
        link_to_button('buttondelete','Delete', workshop, {
          data: {confirm: 'Are you sure?'},
          method: :delete
      })
      ].join(' ').html_safe
    else
      [ link_to(workshop.title,workshop)
      ].join(' ').html_safe
    end
    end
  end

  # This method checks if a user can attend or has registered to attend a training
  def check_workshop_attendee(workshop)
    if(WorkshopRecord.workshop_applied current_user.id, workshop.id).empty?
      link_to "Attend Workshop", attend_workshop_path if workshop.date >= Date.today
    else
      "You have registered for #{workshop.title}"
    end
  end

  # control the navigation links for different user roles
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
