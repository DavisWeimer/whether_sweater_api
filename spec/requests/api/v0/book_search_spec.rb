# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'BookSearches', type: :request do
  before do
    @user = User.create(email: 'book_fiend_123@example.com',
                        password: 'b00k5#r#c00l',
                        password_confirmation: 'b00k5#r#c00l')

    @book_query = {
      location: 'denver,co',
      quantity: 5
    }
  end
  describe 'GET /show' do
    it 'can search books based on a location name!', :vcr do
      get api_v0_book_search_path, params: @book_query,
                                   headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }

      book_trip = JSON.parse(response.body, symbolize_names: true)
      # require 'pry'; binding.pry
      expect(book_trip).to have_key(:data)
      expect(book_trip[:data]).to have_key(:type)
      expect(book_trip[:data]).to have_key(:id)
      expect(book_trip[:data][:id]).to eq(nil)
      expect(book_trip[:data]).to have_key(:attributes)
      expect(book_trip[:data][:type]).to eq('books')
      expect(book_trip[:data][:attributes]).to have_key(:destination)
      expect(book_trip[:data][:attributes][:destination]).to be_a(String)

      # forecast
      expect(book_trip[:data][:attributes]).to have_key(:forecast)
      expect(book_trip[:data][:attributes][:forecast]).to be_a(Hash)
      expect(book_trip[:data][:attributes][:forecast]).to have_key(:condition)
      expect(book_trip[:data][:attributes][:forecast][:condition]).to be_a(String)
      expect(book_trip[:data][:attributes][:forecast]).to have_key(:datetime)
      expect(book_trip[:data][:attributes][:forecast][:datetime]).to be_a(String)
      expect(book_trip[:data][:attributes][:forecast]).to have_key(:temperature)
      expect(book_trip[:data][:attributes][:forecast][:temperature]).to be_a(Float)

      # total_books_found
      expect(book_trip[:data][:attributes]).to have_key(:total_books_found)
      expect(book_trip[:data][:attributes][:total_books_found]).to be_a(Integer)

      # books
      expect(book_trip[:data][:attributes]).to have_key(:books)
      expect(book_trip[:data][:attributes][:books]).to be_a(Array)
      expect(book_trip[:data][:attributes][:books].length).to eq(5)

      book_trip[:data][:attributes][:books].each do |book|
        expect(book).to have_key(:isbn)
        expect(book[:isbn]).to be_a(Array)
        expect(book[:isbn].length).to eq(2)
        expect(book).to have_key(:title)
        expect(book[:title]).to be_a(String)
      end
    end

    it "can't get no dang books without parameters!", :vcr do
      missing_params = {
        location: nil,
        quantity: nil
      }
      get api_v0_book_search_path, params: missing_params,
                                   headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }

      expect(response).to have_http_status(:unprocessable_entity)

      error = JSON.parse(response.body, symbolize_names: true)
      expect(error).to have_key(:error)
      expect(error[:error]).to eq('Missing parameters')
    end

    it "can't get no dang books if the location is misspelled or non-existent!", :vcr do
      incorrect_params = {
        location: 'benver,c1',
        quantity: 5
      }
      get api_v0_book_search_path, params: incorrect_params,
                                   headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }

      expect(response).to have_http_status(:unprocessable_entity)

      error = JSON.parse(response.body, symbolize_names: true)
      expect(error).to have_key(:error)
      expect(error[:error]).to eq('Incorrect/Non-Existent city info')
    end
  end
end
