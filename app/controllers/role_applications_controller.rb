#
# role_applications_controller.rb
#
# This is the controller class for Role Applications. Different users have different permissions to view, update and delete a show.
#

class RoleApplicationsController < ApplicationController
  # Load resources and set actions available
  load_and_authorize_resource
  before_action :set_role_application, only: [:show, :update, :destroy]
  before_filter :set_nav_identifier

  # GET all unprocessed role applications
  def index
    @role_applications = RoleApplication.all
  end

  # GET /role_applications/1
  def show
  end

  # GET new role applications
  def new
    @show_role = ShowRole.find(params[:show_role_id])
    @role_application = RoleApplication.new
  end

  # Create new role application
  def create
    @show_role = ShowRole.find(params[:show_role_id])
    # Create role application for specified params
    @role_application = @show_role.role_applications.create(role_application_params)
    # Identify user
    @role_application.user_id = current_user.id
    # Set current status to Pending
    @role_application.status = "Pending"

    # Save the new application
    if @role_application.save
      redirect_to @role_application, notice: 'Role application was successfully created.'
    else
      render action: 'new'
    end
  end

  # Update role application with params
  def update
    if @role_application.update(role_application_params)
      redirect_to role_applications_url, notice: 'Role application was successfully updated.'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_role_application
      @role_application = RoleApplication.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def role_application_params
      params.require(:role_application).permit(:show_role_id, :user_id, :content, :status)
    end

    def set_nav_identifier
	     @current_nav_identifier	= :shows
    end
end
