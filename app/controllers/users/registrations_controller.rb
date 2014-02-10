#
# registrations_controller.rb
#
# This is a controller class that extends the devise registrations controller
# It adds the additional attributes to the default from devise
#
#

class Users::RegistrationsController < Devise::RegistrationsController
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :set_nav_identifier

  protected
  #method to add the additional required user attributes to the devise default
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << [:firstname, :lastname, :ucard, :course, :level]
  end

  def set_nav_identifier
	  @current_nav_identifier	= :signup
  end

 def after_inactive_sign_up_path_for(resource)
    pages_awaiting_path
 end
end