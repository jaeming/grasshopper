class BoardsController < ApiController
  respond_to :json

  def index
    @boards = Board.all
    respond_with @boards
  end

  def show
    @board = Board.find(params[:id])
    respond_with @board
  end

  def new
    @board = Board.new
    respond_with @board
  end

def create
    if current_user
      @board = current_user.boards.create(board_params)
      respond_with @board
    else
      permission_denied_error
    end
  end

  def edit
    @board = Board.find(params[:id])
    respond_with @board
  end

  def update
    if current_user
      @board = Board.find(params[:id])
      @board.update_attributes(board_params)
      respond_with @board
    else
      permission_denied_error
    end
  end

  def destroy
    if current_user
      @board = Board.find(params[:id])
      @board.destroy
      respond_with @board
    else
      permission_denied_error
    end
  end

  private

  def board_params
    params.require(:board).permit(:title, :text)
  end

end
