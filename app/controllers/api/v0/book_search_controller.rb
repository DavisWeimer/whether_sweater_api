# frozen_string_literal: true

module Api
  module V0
    class BookSearchController < ApplicationController
      def show
        unless params[:location].present? && params[:quantity].present?
          render json: { error: 'Missing parameters' }, status: :unprocessable_entity
          return
        end

        books = BookFacade.books_by_location_title(params[:location], params[:quantity])
        unless (books[:numFound]).positive?
          render json: { error: 'Incorrect/Non-Existent city info' }, status: :unprocessable_entity
          return
        end

        location_coords = LocationFacade.location_coordinates(params[:location])
        forecast = WeatherFacade.get_destination_weather(location_coords, "don't worry about it..")

        render json: BookSerializer.format_books(params[:location], books, forecast), status: :created
      end
    end
  end
end
