require 'rails_helper'

RSpec.describe ForecastSerializer, type: :serializer do
  describe ".class methods" do
    before do
      @location_coords = LocationFacade.location_coordinates("denver,co")
      @forecast = WeatherFacade.get_weather_5_days(@location_coords)
      @forecast[:current][:temp_c] = 25.0
      @forecast[:current][:temp_f] = 77.0
      @forecast[:current][:feelslike_c] = 23.0
      @forecast[:current][:feelslike_f] = 74.0
    end

    it ".weather_information", :vcr do
      serialized_data_metric = ForecastSerializer.weather_information(@forecast, "metric")
      
      expect(serialized_data_metric[:data][:attributes][:current_weather][:temperature]).to eq(25.0)
      expect(serialized_data_metric[:data][:attributes][:current_weather][:feels_like]).to eq(23.0)
      
      serialized_data_imperial = ForecastSerializer.weather_information(@forecast)

      expect(serialized_data_imperial[:data][:attributes][:current_weather][:temperature]).to eq(77.0)
      expect(serialized_data_imperial[:data][:attributes][:current_weather][:feels_like]).to eq(74.0)
    end
  end
end