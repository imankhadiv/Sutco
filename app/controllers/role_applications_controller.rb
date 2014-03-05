class RoleApplicationsController < ApplicationController
  load_and_authorize_resource
  before_action :set_role_application, only: [:show, :edit, :update, :destroy]

  # GET /role_applications
  def index
    @role_applications = RoleApplication.all
@show_roles = ShowRole.all

  end

  # GET /role_applications/1
  def show
  end

  # GET /role_applications/new
  def new
     @show_role = ShowRole.find(params[:show_role_id])
    @role_application = RoleApplication.new
  end

  # GET /role_applications/1/edit
  def edit
  end

  # POST /role_applications
  def create
     @show_role = ShowRole.find(params[:show_role_id])
    @role_application = @show_role.role_applications.create(role_application_params)
    @role_application.user_id = current_user.id
    @role_application.status = "Pending"

    if @role_application.save
      redirect_to @role_application, notice: 'Role application was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /role_applications/1
  def update
    if @role_application.update(role_application_params)
      redirect_to @role_application, notice: 'Role application was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /role_applications/1
  def destroy
    @role_application.destroy
    redirect_to role_applications_url, notice: 'Role application was successfully destroyed.'
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
end
