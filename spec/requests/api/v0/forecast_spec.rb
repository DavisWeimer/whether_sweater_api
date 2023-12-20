# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V0::ForecastController', type: :request do
  let!(:user) { User.create(email: 'test@example.com', password: 'password123', password_confirmation: 'password123') }

  describe 'GET /api/v0/forecast' do
    context 'when authenticated' do
      before do
        post '/login', params: { user: { email: 'test@example.com', password: 'password123' } }
      end

      it 'returns forecast data for a valid location', :vcr do
        get '/api/v0/forecast', params: { location: 'denver,co', units: 'metric' }, headers: { Authorization: token }

        expect(response).to have_http_status(:ok)
        forecast = JSON.parse(response.body, symbolize_names: true)

        expect(forecast[:data][:id]).to eq(nil)
        expect(forecast[:data][:type]).to eq('forecast')

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

    context 'when not authenticated' do
      it 'returns unauthorized', :vcr do
        get '/api/v0/forecast', params: { location: 'denver,co', units: 'metric' }

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