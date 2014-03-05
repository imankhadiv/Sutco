#
# users_controller.rb
#
# This is the controller class for User. It em, contains validations for the user and also
# contains additional methods for authentication and user roles.
#
#

class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show]
  before_filter :set_nav_identifier
  load_and_authorize_resource

  #populate the index page with the list of approved and unapproved users
  def index
    @awaiting_users = User.not_approved
    @approved_users = User.approved
  end

  def edit
  end

  def show
	@fohs = Foh.where(user_id: @user)
  @training_records = @user.training_records
  @workshop_records = @user.workshop_records
  @role_applications = @user.role_applications

  end

  #edit user attributes such as approval status or roles
  def update
    if @user.update(user_params)
      redirect_to users_path, notice: 'User was successfully edited.'
    else
      render action: 'edit'
    end
  end

  #sets the current user for editing / updating
  def set_user
    @user = User.find(params[:id])
  end

  # sets the permitted attributes for a user
  def user_params
    params.require(:user).permit(:approved, :role_ids => [])
  end

  #sets the navigation identifier for the users link on the menu bar
  def set_nav_identifier
    @current_nav_identifier	= :users
  end
end
