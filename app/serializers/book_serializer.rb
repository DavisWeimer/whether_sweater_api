# frozen_string_literal: true

class BookSerializer
  def self.format_books(location, books, forecast)
    {
      data: {
        id: nil,
        type: 'books',
        attributes: {
          destination: location,
          forecast: {
            summary: forecast[:condition],
            temperature: "#{forecast[:temperature]} F"
          },
          total_books_found: books[:numFound],
          books: books[:docs].map do |book|
            {
              isbn: book[:isbn],
              title: book[:title]
            }
          end
        }
      }
    }
  end
end
