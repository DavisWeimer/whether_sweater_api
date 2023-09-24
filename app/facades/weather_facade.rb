class WeatherFacade
  def self.get_weather_5_days(location_coords)
    WeatherService.five_days_weather(location_coords)
  end

  def self.get_destination_weather(destination, time)
    weather = WeatherService.destination_weather(destination, time)
    {
      datetime: weather[:location][:localtime],
      temperature: weather[:current][:temp_f],
      condition: weather[:current][:condition][:text]
    }
  end
end