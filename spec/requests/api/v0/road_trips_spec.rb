# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V0::RoadTripsController', type: :request do
  let!(:user) { User.create(email: 'test@example.com', password: 'password123', password_confirmation: 'password123') }

  describe 'POST /api/v0/road_trips' do
    context 'when authenticated' do
      before do
        post '/login', params: { user: { email: 'test@example.com', password: 'password123' } }
      end

      it 'returns road trip with valid locations', :vcr do
        post '/api/v0/road_trips', params: { origin: "denver,co", destination: "Houston,TX" }, headers: { Authorization: token }

        expect(response).to have_http_status(:ok)
        road_trip = JSON.parse(response.body, symbolize_names: true)
        expect(road_trip).to have_key(:data)
        expect(road_trip[:data]).to have_key(:type)
        expect(road_trip[:data]).to have_key(:id)
        expect(road_trip[:data]).to have_key(:attributes)
        expect(road_trip[:data][:type]).to eq('road_trip')
        expect(road_trip[:data][:attributes]).to have_key(:start_city)
        expect(road_trip[:data][:attributes][:start_city]).to be_a(String)
        expect(road_trip[:data][:attributes]).to have_key(:end_city)
        expect(road_trip[:data][:attributes][:end_city]).to be_a(String)
        expect(road_trip[:data][:attributes]).to have_key(:travel_time)
        expect(road_trip[:data][:attributes][:travel_time]).to be_a(String)
        expect(road_trip[:data][:attributes]).to have_key(:weather_at_eta)
        expect(road_trip[:data][:attributes][:weather_at_eta]).to be_a(Hash)
        expect(road_trip[:data][:attributes][:weather_at_eta]).to have_key(:datetime)
        expect(road_trip[:data][:attributes][:weather_at_eta][:datetime]).to be_a(String)
        expect(road_trip[:data][:attributes][:weather_at_eta]).to have_key(:temperature)
        expect(road_trip[:data][:attributes][:weather_at_eta][:temperature]).to be_a(Float)
        expect(road_trip[:data][:attributes][:weather_at_eta]).to have_key(:condition)
        expect(road_trip[:data][:attributes][:weather_at_eta][:condition]).to be_a(String)
      end
    end

    context 'when not authenticated' do
      it 'returns unauthorized', :vcr do
        get '/api/v0/backgrounds', params: { location: 'denver,co' }

        expect(response).to have_http_status(:unauthorized)
        expect(response.body).to eq("You need to sign in or sign up before continuing.")
      end
    end
  end
end

def json
  JSON.parse(response.body)
end

def token
  response.header["Authorization"]
end
