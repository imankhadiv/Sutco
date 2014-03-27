module ShowsHelper
  # this method is implemented to display the show name and three different icons for view, edit and delete buttons.
  def show_name_links(show)
    content_tag :h3 do
    if (current_user.role? "ProductionTeam")
      [
        link_to_button('buttonshowname',show.name,show),
        link_to_button('buttonedit','Edit', edit_show_path(show)),
        link_to_button('buttondelete','Delete', show, {
          data: {confirm: 'Are you sure?'},
          method: :delete
      })
      ].join(' ').html_safe
    else
      [ link_to(show.name,show)
      ].join(' ').html_safe
    end
    end
  end

  def show_navigation_links(show)
  content_tag :h3 do
    if (current_user.role? "ProductionTeam")
     [
      link_to('<i class="icon-circle-arrow-left"></i> Back'.html_safe,shows_path),
     "|",
      link_to('<i class="icon-edit-sign"></i> Edit'.html_safe,edit_show_path(show))  ,
      "|"                                                        ,
      link_to('<i class="icon-trash"></i> Delete'.html_safe,show, :method => :delete, :data => { :confirm => 'Are you sure?'})
    ].join(' ').html_safe
    else
      [link_to('<i class="icon-circle-arrow-left"></i> Back'.html_safe,shows_path)].join(' ').html_safe
    end
    end
  end
end
