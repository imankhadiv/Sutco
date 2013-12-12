class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update]
  before_filter :set_nav_identifier
  #load_and_authorize_resource

  def index
    @awaiting_users = User.not_approved
    @approved_users = User.approved
  end

  def edit

  end


  def update
    if @user.update(user_params)
      redirect_to users_path, notice: 'User was successfully approved.'
    else
      render action: 'edit'
    end
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:approved, :role_ids => [])
  end

  def set_nav_identifier
    @current_nav_identifier	= :users
  end
end
