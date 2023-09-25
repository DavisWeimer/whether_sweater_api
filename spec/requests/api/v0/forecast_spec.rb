require 'rails_helper'

RSpec.describe "Forecasts", type: :request do
  describe "GET /show" do
    it "retrieves weather for a city", :vcr do
      get "/api/v0/forecast?location=cincinatti,oh"

      expect(response).to be_successful

      forecast = JSON.parse(response.body, symbolize_names: true)

      expect(forecast[:data][:id]).to eq(nil)
      expect(forecast[:data][:type]).to eq("forecast")

      ### current_weather
      expect(forecast[:data][:attributes][:current_weather]).to be_a(Hash)

      expect(forecast[:data][:attributes][:current_weather]).to have_key(:last_updated)
      expect(forecast[:data][:attributes][:current_weather][:last_updated]).to be_a(String)

      expect(forecast[:data][:attributes][:current_weather]).to have_key(:temperature)
      expect(forecast[:data][:attributes][:current_weather][:temperature]).to be_a(Float)

      expect(forecast[:data][:attributes][:current_weather]).to have_key(:feels_like)
      expect(forecast[:data][:attributes][:current_weather][:feels_like]).to be_a(Float)
      
      expect(forecast[:data][:attributes][:current_weather]).to have_key(:humidity)
      expect(forecast[:data][:attributes][:current_weather][:humidity]).to be_a(Integer)

      expect(forecast[:data][:attributes][:current_weather]).to have_key(:uvi)
      expect(forecast[:data][:attributes][:current_weather][:uvi]).to be_a(Float)

      expect(forecast[:data][:attributes][:current_weather]).to have_key(:visibility)
      expect(forecast[:data][:attributes][:current_weather][:visibility]).to be_a(Float)

      expect(forecast[:data][:attributes][:current_weather]).to have_key(:condition)
      expect(forecast[:data][:attributes][:current_weather][:condition]).to be_a(String)
      
      expect(forecast[:data][:attributes][:current_weather]).to have_key(:icon)
      expect(forecast[:data][:attributes][:current_weather][:icon]).to be_a(String)

      ### daily_weather
      expect(forecast[:data][:attributes][:daily_weather]).to be_a(Array)
      expect(forecast[:data][:attributes][:daily_weather].length).to eq(6)

      forecast[:data][:attributes][:daily_weather].each do |daily|
        expect(daily).to have_key(:date)
        expect(daily[:date]).to be_a(String)
        
        expect(daily).to have_key(:sunrise)
        expect(daily[:sunrise]).to be_a(String)
        
        expect(daily).to have_key(:sunset)
        expect(daily[:sunset]).to be_a(String)
        
        expect(daily).to have_key(:max_temp)
        expect(daily[:max_temp]).to be_a(Float)
        
        expect(daily).to have_key(:min_temp)
        expect(daily[:min_temp]).to be_a(Float)
        
        expect(daily).to have_key(:condition)
        expect(daily[:condition]).to be_a(String)
        
        expect(daily).to have_key(:icon)
        expect(daily[:icon]).to be_a(String)
      end

      ### hourly_weather
      forecast[:data][:attributes][:hourly_weather].each do |hourly|
        expect(hourly).to have_key(:time)
        expect(hourly[:time]).to be_a(String)
        
        expect(hourly).to have_key(:temperature)
        expect(hourly[:temperature]).to be_a(Float)

        expect(hourly).to have_key(:conditions)
        expect(hourly[:conditions]).to be_a(String)
        
        expect(hourly).to have_key(:icon)
        expect(hourly[:icon]).to be_a(String)
      end
    end
  end
end
