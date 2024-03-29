#
#     comments_controller.rb
#  This is the controller class for comments. Each conversation has many commnets.
#
#
#


class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  # GET /comments/1
  def show
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
    @count = @conversation.comments.count
    @comment.user_id = current_user.id
    respond_to do |format|
      if @comment.save
        format.js { render 'create_success' }
        @comment.notify_users
        @comment.send_mail
      else
        format.js { render 'create_failure' }
      end
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
    @conversation = Conversation.find(params[:conversation_id])
    @board = Board.find(params[:board_id])
    @comment.destroy
    redirect_to [@board, @conversation], notice: 'Comment was successfully destroyed.'
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
