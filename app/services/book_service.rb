class BookService
  def self.conn
    @_conn ||= Faraday.new(url: "https://openlibrary.org" )
  end

  def self.find_books_by_location_title(location, limit)
    cached_books = Rails.cache.fetch("books_about_#{location}", expires_in: 12.hours) do
      response = conn.get do |req|
        req.url "search.json", title: location, limit: limit
      end
      JSON.parse(response.body, symbolize_names: true)
    end
  end
end