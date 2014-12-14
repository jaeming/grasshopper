class Search
  def self.for(query)
    query_search = "%#{query.downcase}%"

    Board.where('lower(title) LIKE :query or lower(text) LIKE :query', { query: query_search }) +
    Message.where('lower(body) LIKE ?', query_search)
  end
end

# class Search
#   def self.for(query)
#     query_search = "%#{query.downcase}%"

#     Board.where('lower(title) LIKE ? or lower(text) LIKE ?', query_search, query_search) +
#     Message.where('lower(body) LIKE ?', query_search)
#   end
# end