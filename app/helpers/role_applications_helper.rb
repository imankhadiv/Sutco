module RoleApplicationsHelper

	def role_application_navigation_links(role_application)
  content_tag :h3 do
    if (current_user.role? "DramaStudioManager")
     [
      link_to('<i class="icon-circle-arrow-left"></i> Back'.html_safe,role_applications_path)].join(' ').html_safe
    else
      [link_to('<i class="icon-circle-arrow-left"></i> Back'.html_safe,user_path(current_user))].join(' ').html_safe
    end
end
end
end
