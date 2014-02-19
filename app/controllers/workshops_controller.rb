class WorkshopsController < ApplicationController
  before_action :set_workshop, only: [:show, :edit, :update, :destroy]
  before_filter :set_nav_identifier
  load_and_authorize_resource

  # GET /workshops
  def index
    @workshops = Workshop.all
    #@date = params[:month] ? Date.parse(params[:month]) : Date.today
  end

  # GET /workshops/1
  def show
  end

  # GET /workshops/new
  def new
    @workshop = Workshop.new
  end

  # GET /workshops/1/edit
  def edit
  end

  # POST /workshops
  def create
    @workshop = Workshop.new(workshop_params)

    if @workshop.save
      redirect_to @workshop, notice: 'Workshop was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /workshops/1
  def update
    if @workshop.update(workshop_params)
      redirect_to @workshop, notice: 'Workshop was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /workshops/1
  def destroy
    @workshop.destroy
    redirect_to workshops_url, notice: 'Workshop was successfully destroyed.'
  end

  def attend
    user_id = current_user.id
    workshop_id = params[:id]
    WorkshopRecord.create_new_record  user_id, workshop_id
    redirect_to @workshop, notice: "You have successfully registered for #{@workshop.title}"
  end

  def record_attendance
    WorkshopRecord.where(:id => params[:workshop_records_ids]).update_all(["attended=?", true])
    redirect_to workshops_url, notice: "Attendance was successfully updated"
  end


  def attendee
    @workshop_records =  @workshop.workshop_records
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_workshop
      @workshop = Workshop.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def workshop_params
      params.require(:workshop).permit(:title, :description, :date, :time, :duration)
    end

    def set_nav_identifier
	    @current_nav_identifier	= :workshops
    end
end
