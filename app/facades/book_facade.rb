# frozen_string_literal: true

class BookFacade
  def self.books_by_location_title(book_params)
    location_coords = LocationFacade.location_coordinates(book_params[:location])
    forecast = WeatherFacade.get_destination_weather(location_coords, "N/A")
    book_data = BookService.find_books_by_location_title(book_params[:location], book_params[:quantity])
    Books.new(book_data, forecast, book_params[:location])
  end
end
