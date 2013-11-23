class WorkshopAttendancesController < ApplicationController
  before_action :set_workshop_attendance, only: [:show, :edit, :update, :destroy]

  # GET /workshop_attendances
  def index
    @workshop_attendances = WorkshopAttendance.all
  end

  # GET /workshop_attendances/1
  def show
  end

  # GET /workshop_attendances/new
  def new
    @workshop_attendance = WorkshopAttendance.new
  end

  # GET /workshop_attendances/1/edit
  def edit
  end

  # POST /workshop_attendances
  def create
    @workshop_attendance = WorkshopAttendance.new(workshop_attendance_params)

    if @workshop_attendance.save
      redirect_to @workshop_attendance, notice: 'Workshop attendance was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /workshop_attendances/1
  def update
    if @workshop_attendance.update(workshop_attendance_params)
      redirect_to @workshop_attendance, notice: 'Workshop attendance was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /workshop_attendances/1
  def destroy
    @workshop_attendance.destroy
    redirect_to workshop_attendances_url, notice: 'Workshop attendance was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_workshop_attendance
      @workshop_attendance = WorkshopAttendance.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def workshop_attendance_params
      params.require(:workshop_attendance).permit(:username, :recorder, :workshop_id)
    end
end
