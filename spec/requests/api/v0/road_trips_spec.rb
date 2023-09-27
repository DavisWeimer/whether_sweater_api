# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V0::RoadTrips', type: :request do
  before do
    @user = User.create(email: 'im_gettin_hangry@example.com',
                        password: 'password',
                        password_confirmation: 'password',
                        api_key: '640560c67845c6d6f9bb0a3d3ff7c4805c721c6cc659aac0c35be848674e4b00')
  end

  describe 'POST /create' do
    it 'can plan a road trip!', :vcr do
      road_trippin = {
        origin: 'Cincinatti,OH',
        destination: 'Chicago,IL',
        api_key: @user.api_key
      }

      post api_v0_road_trips_path, params: road_trippin.to_json,
                                   headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }
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

    it "can't plan a road trip with missing parameters!", :vcr do
      road_trippin = {
        origin: 'Cincinatti,OH',
        destination: '',
        api_key: @user.api_key
      }

      post api_v0_road_trips_path, params: road_trippin.to_json,
                                   headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }
      expect(response).to have_http_status(:unprocessable_entity)

      error = JSON.parse(response.body, symbolize_names: true)
      expect(error).to have_key(:error)
      expect(error[:error]).to eq('Missing parameters')
    end

    it "can't plan a road trip without an API key!", :vcr do
      road_trippin = {
        origin: 'Cincinatti,OH',
        destination: 'Chicago,IL',
        api_key: 'This Is Not An API Key lmao'
      }

      post api_v0_road_trips_path, params: road_trippin.to_json,
                                   headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }
      expect(response).to have_http_status(:unauthorized)

      error = JSON.parse(response.body, symbolize_names: true)
      expect(error).to have_key(:error)
      expect(error[:error]).to eq('Unauthorized')
    end

    it "can plan a road trip BUT if the destination is too far, the travel time will be 'Impossible'!", :vcr do
      road_trippin = {
        origin: 'New York, NY',
        destination: 'London, UK',
        api_key: @user.api_key
      }

      post api_v0_road_trips_path, params: road_trippin.to_json,
                                   headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }
      expect(response).to have_http_status(:ok)

      road_trip = JSON.parse(response.body, symbolize_names: true)
      expect(road_trip[:data][:attributes][:travel_time]).to eq('Impossible')
      expect(road_trip[:data][:attributes][:weather_at_eta]).to eq('N/A')
    end
  end
end
