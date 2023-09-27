# frozen_string_literal: true

module Api
  module V0
    class BookSearchController < ApplicationController
      def show
        book_params = { location: params[:location], quantity: params[:quantity] }
        unless params[:location].present? && params[:quantity].present?
          render json: { error: 'Missing parameters' }, status: :unprocessable_entity
          return
        end

        books = BookFacade.books_by_location_title(book_params)
        unless books.total_books_found.positive?
          render json: { error: 'Incorrect/Non-Existent city info' }, status: :unprocessable_entity
          return
        end

        render json: BookSerializer.new(books), status: :created
      end
    end
  end
end
