# frozen_string_literal: true

class BookService
  def self.conn
    @conn ||= Faraday.new(url: 'https://openlibrary.org')
  end

  def self.find_books_by_location_title(location, limit)
    Rails.cache.fetch("books:#{location}_qty:#{limit}", expires_in: 12.hours) do
      response = conn.get do |req|
        req.url('search.json', title: location, limit:)
      end
      JSON.parse(response.body, symbolize_names: true)
    end
  end
end
