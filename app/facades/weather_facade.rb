class WeatherFacade
  def self.get_weather_5_days(location_coords)
    WeatherService.five_days_weather(location_coords)
  end
end