class BookSerializer
  def self.format_books(books)
    {
      data: {
        id: nil,
        type: "books",
        attributes: {
          destination: "denver,co",
          forecast: {
            summary: "Cloudy with a chance of meatballs",
            temperature: "83 F"
          },
          total_books_found: 172,
          books: books.map do |book|
            {
              isbn: "isbn",
              title: "title"
            }
          end
        }
      }
    }
  end
end