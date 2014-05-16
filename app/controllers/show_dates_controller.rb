#
# show_dates_controller.rb
#
# This is the controller class for different Show Dates. Different users have different permissions to view, edit, update and delete a show.
#

class ShowDatesController < ApplicationController
  # Load resources and set actions available
  load_and_authorize_resource
  before_action :set_show_date, only: [:show, :edit, :update, :destroy]
  before_filter :set_nav_identifier

  # GET show date
  def show
    redirect_to @show_date.show
  end

  def show_foh
    @show_date = ShowDate.find(params[:id])
    @fohs = @show_date.fohs
  end

  # DELETE show date by date
  def destroy
    @show_date.destroy
    redirect_to @show_date.show, notice: 'Show date was successfully destroyed.'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_show_date
    @show_date = ShowDate.find(params[:id])
  end

  def set_nav_identifier
    @current_nav_identifier = :shows
  end
end
