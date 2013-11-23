class TrainingAttendancesController < ApplicationController
  before_action :set_training_attendance, only: [:show, :edit, :update, :destroy]

  # GET /training_attendances
  def index
    @training_attendances = TrainingAttendance.all
  end

  # GET /training_attendances/1
  def show
  end

  # GET /training_attendances/new
  def new
    @training_attendance = TrainingAttendance.new
  end

  # GET /training_attendances/1/edit
  def edit
  end

  # POST /training_attendances
  def create
    @training_attendance = TrainingAttendance.new(training_attendance_params)

    if @training_attendance.save
      redirect_to @training_attendance, notice: 'Training attendance was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /training_attendances/1
  def update
    if @training_attendance.update(training_attendance_params)
      redirect_to @training_attendance, notice: 'Training attendance was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /training_attendances/1
  def destroy
    @training_attendance.destroy
    redirect_to training_attendances_url, notice: 'Training attendance was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_training_attendance
      @training_attendance = TrainingAttendance.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def training_attendance_params
      params.require(:training_attendance).permit(:username, :recorder, :training_id)
    end
end
