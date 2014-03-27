
class ShowRolesController < ApplicationController
  load_and_authorize_resource
  before_action :set_show_role, only: [:show, :edit, :update, :destroy]
  before_filter :set_nav_identifier
  # GET /roles
  def index
    @show_roles = ShowRole.all
  end


  # GET /roles/new
  def new
    @show_role = ShowRole.new
  end


  # DELETE /roles/1
  def destroy
    @show_role.destroy
    redirect_to @show_role.show, notice: 'Show role was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_show_role
      @show_role = ShowRole.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def show_role_params
      params.require(:show_role).permit(:position, :required_number, :show_id)
    end

  def set_nav_identifier
    @current_nav_identifier	= :shows
  end
end
