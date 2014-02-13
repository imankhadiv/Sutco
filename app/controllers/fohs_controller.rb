class FohsController < ApplicationController
  before_action :set_foh, only: [:show, :edit, :update, :destroy]
  before_filter :set_nav_identifier

  load_and_authorize_resource

  # GET /fohs
  def index
    @show_dates = ShowDate.all
    @fohs = Foh.all
  end

  # GET /fohs/1
  def show
    @show_date = ShowDate.find(params[:show_date_id])

  end

  # GET /fohs/new
  def new
    @show_date = ShowDate.find(params[:show_date_id])
    @positions = Position.where.not(id: Position.joins(:fohs).where(fohs: {show_date_id: @show_date.id}))
    if @positions.empty?
      redirect_to @show_date, notice: 'All positions have been filled. Try a different date'
    end
    @foh = Foh.new
  end

  # GET /fohs/1/edit
  def edit
  end

  # POST /fohs
  def create
    @show_date = ShowDate.find(params[:show_date_id])
    @positions = Position.where.not(id: Position.joins(:fohs).where(fohs: {show_date_id: @show_date.id}))
    @foh = @show_date.fohs.create(foh_params)
    @foh.user_id = current_user.id

    if @foh.save
      redirect_to @show_date, notice: 'You have successfully applied for the position.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /fohs/1
  def update
    if @foh.update(foh_params)
      redirect_to @foh, notice: 'Foh was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /fohs/1
  def destroy
    @show_date = ShowDate.find(params[:show_date_id])
    @foh.destroy
    redirect_to @show_date, notice: 'Foh was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_foh
      @foh = Foh.find(params[:id])
    end
    def set_nav_identifier
      @current_nav_identifier	= :shows
    end
    # Only allow a trusted parameter "white list" through.
    def foh_params
      params.require(:foh).permit(:user_id, :show_date_id, :position_id, :phone_number)
    end
end
