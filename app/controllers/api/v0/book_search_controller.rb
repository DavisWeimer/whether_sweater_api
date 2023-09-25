class Api::V0::BookSearchController < ApplicationController
  def show
    books = BookFacade.books_by_location_title(params[:location], params[:quantity])
    location_coords = LocationFacade.location_coordinates(params[:location])
    forecast = WeatherFacade.get_destination_weather(location_coords, arrival = "don't worry about it..")
    
    render json: BookSerializer.format_books(params[:location], books, forecast), status: :created
  end
end
