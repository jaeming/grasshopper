class SearchController < ApiController
respond_to :json

  def index
    @results = query(Board) + query(Message)
    render json: @results, root: false
  end

  private

  def query(klass)
    klass.search(params[:q]).map { |r| r._source }
  end

end

