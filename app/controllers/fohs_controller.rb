class FohsController < ApplicationController
  before_action :set_foh, only: [:show, :edit, :update, :destroy]

  # GET /fohs
  def index
    @fohs = Foh.all
  end

  # GET /fohs/1
  def show
  end

  # GET /fohs/new
  def new
    @foh = Foh.new
  end

  # GET /fohs/1/edit
  def edit
  end

  # POST /fohs
  def create
    @foh = Foh.new(foh_params)

    if @foh.save
      redirect_to @foh, notice: 'Foh was successfully created.'
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
    @foh.destroy
    redirect_to fohs_url, notice: 'Foh was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_foh
      @foh = Foh.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def foh_params
      params.require(:foh).permit(:position, :required_number, :available_number, :date, :show_id)
    end
end
