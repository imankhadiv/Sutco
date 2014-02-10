#
#
# shows_controller.rb
#
# This is the controller class for Shows. Different users have different permissions to view, create, update and delete a show.

#
class ShowsController < ApplicationController
  load_and_authorize_resource
  before_action :set_show, only: [:show, :edit, :update, :destroy]
  before_filter :set_nav_identifier
  # GET /shows
  def index
    @shows = Show.all
  end

  # GET /shows/1
  def show

  end

  # GET /shows/new
  def new
    @show = Show.new
    @show.show_dates.build
  end

  # GET /shows/1/edit
  def edit
  end

  # POST /shows
  def create
    @show = Show.new(show_params)

    if @show.save
      redirect_to @show, notice: 'Show was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /shows/1
  def update
    if @show.update(show_params)
      redirect_to @show, notice: 'Show was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /shows/1
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
       params.require(:show).permit(:name, :image, :director, :stage_manager, :producer, :synopsis, show_dates_attributes: [:id, :title, :date, :time, :_destroy])
    end

    def set_nav_identifier
	@current_nav_identifier	= :shows
    end

end
