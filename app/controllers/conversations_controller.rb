#
#      conversations_controller.rb
#
# This is the controller class for Conversations. Each board might has many conversations and each conversation has many comments.
#
#
#
#


class ConversationsController < ApplicationController
  before_action :set_conversation, only: [:show, :edit, :update, :destroy]
  before_filter :set_nav_identifier

  # GET /conversations/1
  def show
    @board = Board.find(params[:board_id])
    @comments = @conversation.comments
    @new_comment = Comment.new
    Notification.remove_notification current_user, @conversation
  end

  # GET /conversations/new
  def new
    @board = Board.find(params[:board_id])
    @conversation = Conversation.new
  end


  # POST /conversations
  def create
    @board = Board.find(params[:board_id])
    @conversation = @board.conversations.create(conversation_params)
    @conversation.user_id = current_user.id

    if @conversation.save
      redirect_to @board, notice: 'Conversation was successfully created.'
    else
      render action: 'new'
    end
  end

  # DELETE /conversations/1
  def destroy
    @board = Board.find(params[:board_id])
    @conversation.destroy
    redirect_to @board, notice: 'Conversation was successfully moderated.'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_conversation
    @conversation = Conversation.find(params[:id])
  end

  def set_nav_identifier
    @current_nav_identifier = :boards
  end

  # Only allow a trusted parameter "white list" through.
  def conversation_params
    params.require(:conversation).permit(:title, :body, :board_id, :user_id)
  end
end
