require 'rails_helper'

RSpec.describe "Api::V0::RoadTrips", type: :request do
  describe "POST /create" do
    it "can plan a road trip!", :vcr do
      user = User.create(email: "im_gettin_hangry@example.com",
                        password: "password", 
                        password_confirmation: "password", 
                        api_key: "640560c67845c6d6f9bb0a3d3ff7c4805c721c6cc659aac0c35be848674e4b00")
  
      road_trippin = {
        origin: "Cincinatti,OH",
        destination: "Chicago,IL",
        api_key: user.api_key
      }
    
      post api_v0_road_trips_path, params: road_trippin.to_json, headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }
      expect(response).to have_http_status(:ok)
  
      road_trip = JSON.parse(response.body, symbolize_names: true)
      expect(road_trip).to have_key(:data)
      expect(road_trip[:data]).to have_key(:type)
      expect(road_trip[:data]).to have_key(:id)
      expect(road_trip[:data]).to have_key(:attributes)
      expect(road_trip[:data][:type]).to eq("road_trip")
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
      expect(road_trip[:data][:attributes][:weather_at_eta][:condition]).to be_a(Float)
    end
  end
end
