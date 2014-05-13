#
#  Calenders_controller.rb
#


class CalendarsController < ApplicationController
  #before_action :set_calendar, only: [:show]
  before_filter :set_nav_identifier
  before_filter :authenticate_user!


  # GET /calendars
  def index
    @events = Workshop.all + Training.all + Social.all + ShowDate.all
    @date = params[:month] ? Date.parse(params[:month]) : Date.today
  end


  private
  def set_nav_identifier
    @current_nav_identifier = :calendar
  end

end
