class MessagesController < ApiController
  respond_to :json

  def index
    @board = Board.find(params[:board_id])
    @message = @board.messages
    render json: @message, root: false
  end

  def show
    @board = Board.find(params[:board_id])
    @message = @board.messages.find(params[:id])
    respond_with @message
  end

  def create
    if current_user
      @board = Board.find(params[:board_id])
      @message = current_user.messages.create(message_params.merge(board: @board))
      render json: @message
    else
      permission_denied_error
    end
  end

  def edit
    @board = Board.find(params[:board_id])
    @message = @board.messages.find(params[:id])
    respond_with @message
  end

  def update
    if current_user
      @board = Board.find(params[:board_id])
      @message = @board.messages.find(params[:id])
      @message.update_attributes(message_params)
      respond_with @message
    else
      permission_denied_error
    end
  end

  def destroy
    if current_user
      @board = Board.find(params[:board_id])
      @message = @board.messages.find(params[:id])
      @message.destroy
      respond_with @message
    else
      permission_denied_error
    end
  end

  private
    def message_params
      params.require(:message).permit(:body)
    end
end
