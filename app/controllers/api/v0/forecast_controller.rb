class Api::V0::ForecastController < ApplicationController
  def show
    location_coords = LocationFacade.location_coordinates(params[:location])

    forecast = WeatherFacade.get_weather_5_days(location_coords)
    
    render json: ForecastSerializer.weather_information(forecast)
  end
end