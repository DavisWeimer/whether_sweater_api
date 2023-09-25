class WeatherFacade
  def self.get_weather_5_days(location_coords)
    WeatherService.five_days_weather(location_coords)
  end

  def self.get_destination_weather(destination, time, units = "imperial")
    weather = WeatherService.destination_weather(destination, time)
    serialized_weather = serialize_weather(weather, units)
    serialized_weather
  end

  private

  def self.serialize_weather(weather, units = "not metric")
    temperature_key = units == "metric" ? :temp_c : :temp_f

    {
      datetime: weather[:location][:localtime],
      temperature: weather[:current][temperature_key],
      condition: weather[:current][:condition][:text]
    }
  end
end