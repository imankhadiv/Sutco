#
# trainings_controller.rb
#
# This is the controller class for Training events. Different users have different permissions to view, create, update, and delete a training event.
# Users can also attend and have their attendance record marked
#
class TrainingsController < ApplicationController
  before_action :set_training, only: [:show, :edit, :update, :destroy, :attendee]
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

  # Custom method to register to attend a training session
  def attend
    user_id = current_user.id
    training_id = params[:id]
    TrainingRecord.create_new_record  user_id, training_id
    redirect_to @training, notice: "You have successfully registered for #{@training.title}"
  end

  # Displays attendance records of a workshop
  def attendee
    @training_records =  @training.training_records
  end

  # Custom method to mark the attendance record of a training event
  def record_attendance
    TrainingRecord.where(id:params[:unattended_ids]).update_all(attended:true)
    redirect_to trainings_url, notice: "The attendance was successfully updated"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_training
      @training = Training.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def training_params
      params.require(:training).permit(:title, :category, :description, :date, :time, :duration)
    end

    def set_nav_identifier
	@current_nav_identifier	= :events
    end

end
