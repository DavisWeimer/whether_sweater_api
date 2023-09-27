# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Forecast, type: :poro do
  describe '#methods' do
    it '#units_logic', :vcr do
      @location_coords = LocationFacade.location_coordinates('denver,co')
      @forecast_f = WeatherFacade.get_weather_5_days(@location_coords)
      @forecast_c = WeatherFacade.get_weather_5_days(@location_coords, 'metric')

      expect(@forecast_f.current_weather[:temperature]).to be > @forecast_c.current_weather[:temperature]
      expect(@forecast_f.current_weather[:feels_like]).to be > @forecast_c.current_weather[:feels_like]
    end
  end
end
