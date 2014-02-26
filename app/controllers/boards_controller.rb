class BoardsController < ApplicationController
  before_action :set_board, only: [:show, :edit, :update, :destroy]

  # GET /boards
  def index
    @boards = Board.all
  end

  # GET /boards/1
  def show
    @conversations = @board.conversations
  end

  # GET /boards/new
  def new
    @board = Board.new
  end

  # GET /boards/1/edit
  def edit
  end

  # POST /boards
  def create
    @board = Board.new(board_params)

    if @board.save
      redirect_to @board, notice: 'Board was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /boards/1
  def update
    if @board.update(board_params)
      redirect_to @board, notice: 'Board was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /boards/1
  def destroy
    @board.destroy
    redirect_to boards_url, notice: 'Board was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_board
      @board = Board.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def board_params
      params.require(:board).permit(:title)
    end
end
