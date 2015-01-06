class SearchController < ApiController
respond_to :json

  def index
    if params[:q].present?
      @board_results = Board.search(search_params)
      @message_results = Message.search(search_params)
      @search = [@board_results, @message_results]
      render json: @search, root: false
    else
      @search = []
    end
  end

  private

  def search_params
    params[:q].split.join(' AND ')
  end

end