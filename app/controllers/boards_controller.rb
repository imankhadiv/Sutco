class BoardsController < ApplicationController
  before_action :set_board, only: [:show, :edit, :update, :destroy]
  before_filter :set_nav_identifier
  load_and_authorize_resource

  # GET /boards
  def index
    @boards = Board.all
  end

  # GET /boards/1
  def show
    @conversations = @board.conversations
    if (!@board.public)

      @show_roles = ShowRole.select('id').where(show_id: @board.show.id)
      @user_ids = RoleApplication.where(show_role_id: @show_roles, status: 'Approved').pluck(:user_id)
      #render :text => @user_ids.inspect

    unless (user_can_view_board(@user_ids)) || (current_user.role? "ProductionTeam")
        flash[:error] = "You can't view this board"
        redirect_to root_path
      end
    end
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

    def set_nav_identifier
      @current_nav_identifier	= :boards
    end

    def user_can_view_board(users)
     if users.include? current_user.id
        true
     else
         false
       end
    end

end
