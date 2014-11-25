class MessagesController < ApiController
  respond_to :json

  def index
    @board = Board.find(params[:board_id])
    @message = @board.messages
    respond_with @message
  end


  def create
    @board = Board.find(params[:board_id])
    @message = @board.messages.create(message_params)
    render json: @message
  end

  def destroy
    @board = Board.find(params[:board_id])
    @message = @board.messages.find(params[:id])
    @message.destroy
    respond_with @message
  end

  private
    def message_params
      params.require(:message).permit(:body)
    end
end
