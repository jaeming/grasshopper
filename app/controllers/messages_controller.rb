class messagesController < ApiController
  respond_to :json
  def index
    @messages = Message.all
    respond_with @boards
  end

  def show
    @message = Message.find(params[:id])
    respond_with @message
  end

  def new
    @message = Message.new
    respond_with @message
  end

  def create
    @message = Message.create(board_params)
    respond_with @message
  end

  def edit
    @message = Message.find(params[:id])
    respond_with @message
  end

  def update
    @message = Message.find(params[:id])
    respond_with @message
  end

  def destroy
    @message = Message.find(params[:id])
    @message.destroy
    respond_with @message
  end

  private

  def message_params
    params.require(:message).permit(:text)
  end

end
