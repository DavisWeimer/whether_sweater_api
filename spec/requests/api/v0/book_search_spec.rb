require 'rails_helper'

RSpec.describe "BookSearches", type: :request do
  before do
    @user = User.create(email: "book_fiend_123@example.com",
      password: "b00k5#r#c00l", 
      password_confirmation: "b00k5#r#c00l", 
      )
    
    @book_query = {
      location: "denver,co",
      quantity: 5
    }
  end
  describe "GET /show" do
    it "can search books based on a location name!", :vcr do
      require 'pry'; binding.pry
      get api_v0_book_search_path, params: @book_query, headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }

      book_trip = JSON.parse(response.body, symbolize_names: true)

      expect(road_trip).to have_key(:data)
      expect(road_trip[:data]).to have_key(:type)
      expect(road_trip[:data]).to have_key(:id)
      expect(road_trip[:data][:id]).to eq(nil)
      expect(road_trip[:data]).to have_key(:attributes)
      expect(road_trip[:data][:type]).to eq("books")
      expect(road_trip[:data][:attributes]).to have_key(:destination)
      expect(road_trip[:data][:attributes][:destination]).to be_a(String)

      # forecast
      expect(road_trip[:data][:attributes]).to have_key(:forecast)
      expect(road_trip[:data][:attributes][:forecast]).to be_a(Hash)
      expect(road_trip[:data][:attributes][:forecast]).to have_key(:summary)
      expect(road_trip[:data][:attributes][:forecast][:summary]).to be_a(String)
      expect(road_trip[:data][:attributes][:forecast]).to have_key(:temperature)
      expect(road_trip[:data][:attributes][:forecast][:temperature]).to be_a(String)

      # total_books_found
      expect(road_trip[:data][:attributes]).to have_key(:total_books_found)
      expect(road_trip[:data][:attributes][:total_books_found]).to be_a(Integer)
      
      # books
      expect(road_trip[:data][:attributes]).to have_key(:books)
      expect(road_trip[:data][:attributes][:books]).to be_a(Hash)
      expect(road_trip[:data][:attributes][:books].length).to eq(5)
      expect(road_trip[:data][:attributes][:books]).to have_key(:isbn)
      expect(road_trip[:data][:attributes][:books][:isbn]).to be_a(Array)
      expect(road_trip[:data][:attributes][:books][:isbn].length).to eq(2)
      expect(road_trip[:data][:attributes][:forecast]).to have_key(:title)
      expect(road_trip[:data][:attributes][:forecast][:title]).to be_a(String)
    end
  end
end
