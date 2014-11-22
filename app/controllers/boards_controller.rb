class BoardsController < ApplicationController
  respond_to :json

  def index
    @boards = Board.all
    respond_with @boards
    # render json: @boards
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
    @board = Board.new(board_params)
    respond_with @board
  end

  def edit
    @board = Board.find(params[:id])
    respond_with @board
  end

  def update
    @board = Board.find(params[:id])
    respond_with @board
  end

  def destroy
    @board = Board.find(params[:id])
    @board.destroy
    respond_with @board
  end

  private

  def board_params
    params.permit(:title, :text)
  end

end
