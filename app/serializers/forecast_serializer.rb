class ForecastSerializer
  def self.weather_information(forecast, units = "imperial")
    temperature_key = units == "imperial" ? :temp_f : :temp_c
    feels_like_key = units == "imperial" ? :feelslike_f : :feelslike_c
    max_temp_key = units == "imperial" ? :maxtemp_f : :maxtemp_c
    min_temp_key = units == "imperial" ? :mintemp_f : :mintemp_c

    {
      data: {
        id: "null",
        type: "forecast",
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