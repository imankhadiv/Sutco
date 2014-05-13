#
# show_roles_controller.rb
#
# This is the controller class for Show Roles. Different users have different permissions to view, update, edit and delete a show.
#
class ShowRolesController < ApplicationController
  # Load resources and set actions available
  load_and_authorize_resource
  before_action :set_show_role, only: [:show, :edit, :update, :destroy]
  before_filter :set_nav_identifier
  # GET all show roles
  def index
    @show_roles = ShowRole.all
  end

  # DELETE role by ID
  def destroy
    @show_role.destroy
    redirect_to @show_role.show, notice: 'Show role was successfully destroyed.'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_show_role
    @show_role = ShowRole.find(params[:id])
  end

  def set_nav_identifier
    @current_nav_identifier = :shows
  end
end
