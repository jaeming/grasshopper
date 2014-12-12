class Search
  def self.for(query)
    query_search = "%#{query.downcase}%"

    Board.where('lower(title) LIKE ?', query_search) +
    Board.where('lower(text) LIKE ?', query_search) +
    Message.where('lower(body) LIKE ?', query_search)
  end
end