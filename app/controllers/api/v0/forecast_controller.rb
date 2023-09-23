class Api::V0::ForecastController < ApplicationController
  def show
    location_coords = LocationFacade.location_coordinates(params[:location])

    forecast = WeatherFacade.get_weather_5_days(location_coords)


    # begin
    #   render json: { data: VendorSerializer.format_vendor(Vendor.find(params[:id])) }
    # rescue StandardError => e
    #   vendor_not_found(e)
    # end
    require 'pry'; binding.pry
  end
end