class CalendarsController < ApplicationController
  before_action :set_calendar, only: [:show]
  before_filter :set_nav_identifier
  before_filter :authenticate_user!


  # GET /calendars
  def index
    @events = Workshop.all + Training.all + Social.all + ShowDate.all
    @date = params[:month] ? Date.parse(params[:month]) : Date.today
  end

  # GET /calendars/1
  def show
  end

  # POST /calendars
  def create
    @calendar = Calendar.new(calendar_params)

    if @calendar.save
      redirect_to @calendar, notice: 'Calendar was successfully created.'
    else
      render action: 'new'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_calendar
      @calendar = Calendar.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def calendar_params
      params.require(:calendar).permit(:title, :description, :date)
    end

    def set_nav_identifier
	@current_nav_identifier	= :calendar
    end

end
