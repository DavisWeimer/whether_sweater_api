# frozen_string_literal: true

class WeatherFacade
  def self.get_weather_5_days(location_coords, units = '')
    forecast_data = WeatherService.five_days_weather(location_coords)
    Forecast.new(forecast_data, units)
  end

  def self.get_destination_weather(destination, time, units = 'imperial')
    weather = WeatherService.destination_weather(destination, time)
    serialize_weather(weather, units)
  end

  def self.serialize_weather(weather, units = 'not metric')
    temperature_key = units == 'metric' ? :temp_c : :temp_f

    {
      datetime: weather[:location][:localtime],
      temperature: weather[:current][temperature_key],
      condition: weather[:current][:condition][:text]
    }
  end
end
