class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  # GET /comments
  def index
    @comments = Comment.all
  end

  # GET /comments/1
  def show
  end

  # GET /comments/new
  def new
    @comment = Comment.new
    @board = Board.find(params[:board_id])

    @conversation = Conversation.find(params[:conversation_id])

  end

  # GET /comments/1/edit
  def edit
    @board = Board.find(params[:board_id])
    @conversation = Conversation.find(params[:conversation_id])
  end

  # POST /comments
  def create
    @board = Board.find(params[:board_id])
    @conversation = Conversation.find(params[:conversation_id])
    @comment = @conversation.comments.create(comment_params)
    @comment.user_id = current_user.id
    @comment.notify_users

    if @comment.save
      redirect_to board_conversation_path(@board, @conversation), notice: 'Comment was successfully created.'
    else
      flash[:error] = 'You have not entered any comment!'
      redirect_to board_conversation_path(@board, @conversation)
    end
  end

  # PATCH/PUT /comments/1
  def update
    if @comment.update(comment_params)
      redirect_to @comment, notice: 'Comment was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /comments/1
  def destroy
    @comment.destroy
    redirect_to comments_url, notice: 'Comment was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def comment_params
      params.require(:comment).permit(:user_id, :conversation_id, :body)
    end
end
