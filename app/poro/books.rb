class Books
  attr_reader :id, 
              :type, 
              :destination, 
              :forecast, 
              :total_books_found,
              :books

  def initialize(book_data, forecast, location)
    @id = nil
    @type = "books"
    @destination = location
    @forecast = forecast
    @total_books_found = book_data[:numFound]
    @books = book_data[:docs].map { |book| { isbn: book[:isbn], title: book[:title] } }
  end
end