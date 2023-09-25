class BookFacade
  def self.books_by_location_title(location, limit)
    BookService.find_books_by_location_title(location, limit)
  end
end