#
# shows_controller.rb
#
# This is the controller class for Shows. Different users have different permissions to view, create, update and delete a show.
#
class ShowsController < ApplicationController
  # Load resources and set actions available
  load_and_authorize_resource
  before_action :set_show, only: [:show, :edit, :update, :destroy]
  before_filter :set_nav_identifier
  # GET all shows
  def index
    @shows = Show.all
  end

  # GET show by ID
  def show
    @board = Board.find_by_show_id(@show.id)
    @show_roles = ShowRole.select('id').where(show_id: @show.id)
    @user_ids = RoleApplication.where(show_role_id: @show_roles, status: 'Approved').pluck(:user_id)
  end

  # GET new shows
  def new
    @show = Show.new
    @show.show_dates.build
    @show.show_roles.build
  end

  # edit new shows
  def edit
  end

  # POST /shows
  def create
    @show = Show.new(show_params)

    # Check successful update
    if @show.save
      redirect_to @show, notice: 'Show was successfully created.'
    else
      render action: 'new'
    end
  end

  # Update show
  def update

    # Check for successful update
    if @show.update(show_params)
      # Find show by ID
      board = Board.find_by_show_id(@show.id)
      # Update params
      board.title= @show.name
      board.save
      redirect_to @show, notice: 'Show was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE show by ID
  def destroy
    @show.destroy
    redirect_to shows_url, notice: 'Show was successfully destroyed.'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_show
    @show = Show.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def show_params
    params.require(:show).permit(:name, :image, :image_cache, :remove_image, :director, :stage_manager, :producer, :synopsis, show_dates_attributes: [:id, :title, :date, :time, :_destroy], show_roles_attributes: [:id, :position, :required_number, :_destroy])
  end

  def set_nav_identifier
    @current_nav_identifier = :shows
  end

end
