# frozen_string_literal: true

class ForecastSerializer
  def self.weather_information(forecast, units = 'not metric lol')
    temperature_key = units == 'metric' ? :temp_c : :temp_f
    feels_like_key = units == 'metric' ? :feelslike_c : :feelslike_f
    max_temp_key = units == 'metric' ? :maxtemp_c : :maxtemp_f
    min_temp_key = units == 'metric' ? :mintemp_c : :mintemp_f

    {
      data: {
        id: nil,
        type: 'forecast',
        attributes: {
          current_weather: {
            last_updated: forecast[:current][:last_updated],
            temperature: forecast[:current][temperature_key],
            feels_like: forecast[:current][feels_like_key],
            humidity: forecast[:current][:humidity],
            uvi: forecast[:current][:uv],
            visibility: forecast[:current][:vis_miles],
            condition: forecast[:current][:condition][:text],
            icon: forecast[:current][:condition][:icon]
          },
          daily_weather: forecast[:forecast][:forecastday].map do |daily|
            {
              date: daily[:date],
              sunrise: daily[:astro][:sunrise],
              sunset: daily[:astro][:sunset],
              max_temp: daily[:day][max_temp_key],
              min_temp: daily[:day][min_temp_key],
              condition: daily[:day][:condition][:text],
              icon: daily[:day][:condition][:icon]
            }
          end,
          hourly_weather: forecast[:forecast][:forecastday][0][:hour].map do |hourly|
            {
              time: hourly[:time][/\d{2}:\d{2}/],
              temperature: hourly[temperature_key],
              conditions: hourly[:condition][:text],
              icon: hourly[:condition][:icon]
            }
          end
        }
      }
    }
  end
end
