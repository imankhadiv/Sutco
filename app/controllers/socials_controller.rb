class SocialsController < ApplicationController
  load_and_authorize_resource
  before_action :set_social, only: [:show, :edit, :update, :destroy]
  before_filter :set_nav_identifier


  # GET /socials
  def index
    @socials = Social.all
  end

  # GET /socials/1
  def show
  end

  # GET /socials/new
  def new
    @social = Social.new
  end

  # GET /socials/1/edit
  def edit
  end

  # POST /socials
  def create
    @social = Social.new(social_params)

    if @social.save
      redirect_to @social, notice: 'Social was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /socials/1
  def update
    if @social.update(social_params)
      redirect_to @social, notice: 'Social was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /socials/1
  def destroy
    @social.destroy
    redirect_to socials_url, notice: 'Social was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_social
      @social = Social.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def social_params
      params.require(:social).permit(:title, :location, :description, :date, :time, :duration)
    end

    def set_nav_identifier
      @current_nav_identifier	= :events
    end
end
