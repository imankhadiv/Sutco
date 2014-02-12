module ShowsHelper
  # this method is implemented to display the show name and three different icons for view, edit and delet buttons.
  def show_name_links(show)
    content_tag :h3 do
    if ((current_user.role? "SeniorCommittee") || (current_user.role? "TechManager"))
      [ show.name,
        link_to_icon('icon-desktop','View','View', show),
        link_to_icon('icon-edit-sign','Edit','Edit', edit_show_path(show)),
        link_to_icon('icon-trash','Delete','Delete', show, {
          confirm: 'Are you sure?',
          method: :delete
      })
      ].join(' ').html_safe
    else
      [ link_to(show.name,show)
      ].join(' ').html_safe
    end
    end
  end
end
