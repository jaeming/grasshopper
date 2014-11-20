class BoardsController < ApplicationController
  respond_to :html, :json

  def index
    @board = Board.all
    respond_with(@board) do |format|
      format.json { render }
    end
  end

  def show
    @board = Board.find(params[:id])
    respond_with(@board) do |format|
      format.json { render }
    end
  end

  def new
    @board = Board.new
  end

  def create
    @board = Board.new(board_params)

    if @board.save
      redirect_to @board
    else
      render 'new'
    end
  end

  def edit
    @board = Board.find(params[:id])
  end

  def update
    @board = Board.find(params[:id])

    if @board.update(board_params)
      redirect_to @board
    else
      render 'edit'
    end
  end

  def destroy
    @board = Board.find(params[:id])
    @board.destroy

    redirect_to boards_path
  end

  private

  def board_params
    params.require(:board).permit(:title, :text)
  end

end
