class BoardsController < ApiController
  respond_to :json
  before_action :authenticate, except: [:index, :show]

  def index
    @boards = Board.order("created_at DESC").all
    render json: @boards, root: false
  end

  def show
    @board = Board.find(params[:id])
    render json: @board, root: false
  end

  def new
    @board = Board.new
    respond_with @board
  end

  def create
    @board = @user.boards.create(board_params)
    respond_with @board
  end

  def edit
    @board = Board.find(params[:id])
    respond_with @board
  end

  def update
    @board = Board.find(params[:id])
    if @user == @board.user
      @board.update_attributes(board_params)
      respond_with @board
    else
      permission_denied_error
    end
  end

  def destroy
    @board = Board.find(params[:id])
    if @user == @board.user
      @board.destroy
      respond_with @board
    else
      permission_denied_error
    end
  end

  private

    def board_params
      params.permit(:title, :text)
    end

  end
