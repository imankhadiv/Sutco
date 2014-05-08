#
# socials_helper.rb
#
# This is an helper class for Socials. It contains a method for displaying navigation links based on the current logged in user
#
module SocialsHelper
# This method controls the navigation links for different user roles
def social_navigation_links(social)
    content_tag :h3 do
      if ((current_user.role? "SeniorCommittee") || (current_user.role? "Committee") || (current_user.role? "ProductionTeam"))
        [
            link_to('<i class="icon-circle-arrow-left"></i> Back'.html_safe,socials_path),
            "|",
            link_to('<i class="icon-edit-sign"></i> Edit'.html_safe,edit_social_path(social))  ,
            "|"                                                        ,
            link_to('<i class="icon-trash"></i> Delete'.html_safe,social, :method => :delete, :data => { :confirm => 'Are you sure?'})
        ].join(' ').html_safe
      else
        [link_to('<i class="icon-circle-arrow-left"></i> Back'.html_safe,socials_path)].join(' ').html_safe
      end
    end
  end

end
