class ApplicationController < ActionController::Base
  rescue_from DeviseLdapAuthenticatable::LdapException do |exception|
    render :text => exception, :status => 500
  end
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :ie6_warning

  # Catch NotFound exceptions and handle them neatly, when URLs are mistyped or mislinked
  rescue_from ActiveRecord::RecordNotFound do
    render template: 'errors/not_found', status: 404
  end
  
  # 403 page for Cancan
  rescue_from CanCan::AccessDenied do
    render template: 'errors/forbidden', status: 403
  end

  # Uncomment if using LDAP
  # rescue_from Net::LDAP::LdapError do
  #   redirect_to new_user_session_path, alert: "The authentication server did not respond. Please try again."
  # end
  
  ## Force us to have cancan authorization in all controllers
  #check_authorization unless: :devise_controller?


  ## UNCOMMENT THIS CODE TO DISABLE CACHING IF DEALING WITH SENSITIVE DATA
  # before_filter :update_headers
  # def send_file(file, opts={})
  #   # IE over HTTPS will not download if browser caching is off, so allow browser caching when sending files
  #   response.headers['Cache-Control'] = 'private, proxy-revalidate' # Still prevent proxy caching
  #   response.headers['Pragma'] = 'cache'
  #   response.headers['Expires'] = '0'
  #   super(file, opts)
  # end
  # protected
  #   def update_headers
  #     response.headers['Cache-Control'] = 'no-cache, no-cache="set-cookie", no-store, private, proxy-revalidate'
  #     response.headers['Pragma'] = 'no-cache'
  #     response.headers['Expires'] = '-1'
  #   end

  
  private 
    def ie6_warning
      redirect_to ie6_warning_path if request.user_agent.to_s =~ /MSIE 6/
    end
end
