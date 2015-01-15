class MessagesController < ApiController
  respond_to :json
  before_action :authenticate, except: [:index, :show]

  def index
    @board = Board.find(params[:board_id])
    @message = @board.messages.order("created_at DESC").all
    render json: @message, root: false
  end

  def show
    @board = Board.find(params[:board_id])
    @message = @board.messages.find(params[:id])
    render json: @message, root: false
  end

  def create
    @board = Board.find(params[:board_id])
    @message = @user.messages.create(message_params.merge(board: @board))
    render json: @message
  end

  def edit
    @board = Board.find(params[:board_id])
    @message = @board.messages.find(params[:id])
    respond_with @message
  end

  def update
    @board = Board.find(params[:board_id])
    @message = @board.messages.find(params[:id])
    if @user == @message.user
      @message.update_attributes(message_params)
      respond_with @message
    else
      permission_denied_error
    end
  end

  def destroy
    @board = Board.find(params[:board_id])
    @message = @board.messages.find(params[:id])
    if @user == @message.user
      @message.destroy
      respond_with @message
    else
      permission_denied_error
    end
  end

  private

    def message_params
      params.permit(:body)
    end

end
