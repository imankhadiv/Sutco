class TrainingsController < ApplicationController
  before_action :set_training, only: [:show, :edit, :update, :destroy]
  before_filter :set_nav_identifier
  load_and_authorize_resource

  # GET /trainings
  def index
    @trainings = Training.all
  end

  # GET /trainings/1
  def show
  end

  # GET /trainings/new
  def new
    @training = Training.new
  end

  # GET /trainings/1/edit
  def edit
  end

  # POST /trainings
  def create
    @training = Training.new(training_params)

    if @training.save
      redirect_to @training, notice: 'Training was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /trainings/1
  def update
    if @training.update(training_params)
      redirect_to @training, notice: 'Training was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /trainings/1
  def destroy
    @training.destroy
    redirect_to trainings_url, notice: 'Training was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_training
      @training = Training.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def training_params
      params.require(:training).permit(:title, :category, :date, :description)
    end

    def set_nav_identifier
	@current_nav_identifier	= :trainings
    end

end
