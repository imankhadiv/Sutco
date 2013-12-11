module ShowsHelper

  def show_name_links(show)
    content_tag :h3 do
      [ show.name,
        link_to_icon('icon-desktop', show),
        link_to_icon(' icon-edit-sign', edit_show_path(show)),
        link_to_icon('icon-trash', show, {
          confirm: 'Are you sure?',
          method: :delete
      })
      ].join(' ').html_safe
    end
  end
end
