#
#   boards_controller.rb
#   There is one public message board in the system and one message board for each shows.
#   Each board may has many conversations and each conversation may has many comments.
#
#


class BoardsController < ApplicationController
  before_action :set_board, only: [:show] #, :edit, :update, :destroy]
  before_filter :set_nav_identifier
  load_and_authorize_resource

  # GET /boards
  def index
    @boards = Board.all
  end

  # GET /boards/1
  def show
    @conversations = @board.conversations.order('updated_at desc')
    unless (@board.authorized(current_user) || (current_user.role? "ProductionTeam") || (current_user.role? "SeniorCommittee"))
      flash[:error] = "You can't view this board"
      redirect_to root_path
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_board
    @board = Board.find(params[:id])
  end

  def set_nav_identifier
    @current_nav_identifier = :boards
  end

end
