# frozen_string_literal: true

module Api
  module V0
    class ForecastController < ApplicationController
      def show
        location_coords = LocationFacade.location_coordinates(params[:location])

        forecast = WeatherFacade.get_weather_5_days(location_coords)

        render json: ForecastSerializer.weather_information(forecast, params[:units])
      end
    end
  end
end
