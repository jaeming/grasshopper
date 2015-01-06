class SearchController < ApiController
respond_to :json

  def index
    if params[:q].present?
      @board_title = Board.search(search_params).map { |r| r._source}
      @message_body = Message.search(search_params).map { |r| r._source}
      @search = @board_title + @message_body
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

