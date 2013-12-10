class Users::RegistrationsController < Devise::RegistrationsController
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :set_nav_identifier

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << [:firstname, :lastname, :ucard, :course, :level]
  end

    def set_nav_identifier
	@current_nav_identifier	= :signup
    end

 # def after_sign_up_path_for(resource)
 #   pages_awaiting_path
 # end
end