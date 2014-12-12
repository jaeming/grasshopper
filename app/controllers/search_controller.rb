class SearchController < ApiController
respond_to :json

  def index
    @results = Search.for(params[:query])
    render json: @results
  end

end