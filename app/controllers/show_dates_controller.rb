class ShowDatesController < ApplicationController
  load_and_authorize_resource
  before_action :set_show_date, only: [:show, :edit, :update, :destroy]

  # GET /show_dates
  #def index
   # @show_dates = ShowDate.all
  #end

  # GET /show_dates/1
  def show
	  redirect_to @show_date.show
  end

  # GET /show_dates/new
  def new
    @show_date = ShowDate.new
  end

  # GET /show_dates/1/edit
  def edit
  end

  # POST /show_dates
  def create
    @show_date = ShowDate.new(show_date_params)

    if @show_date.save
      redirect_to @show_date, notice: 'Show date was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /show_dates/1
  def update
    if @show_date.update(show_date_params)
      redirect_to @show_date, notice: 'Show date was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /show_dates/1
  def destroy
    @show_date.destroy
    redirect_to @show_date.show, notice: 'Show date was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_show_date
      @show_date = ShowDate.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def show_date_params
      params.require(:show_date).permit(:title, :date, :time, :show_id)
    end
end
