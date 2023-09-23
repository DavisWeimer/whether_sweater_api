class ForecastSerializer
  def self.weather_information(forecast)
    {
      data: {
        id: "null",
        type: "forecast",
        attributes: {
          current_weather: {
            last_updated: forecast[:current][:last_updated], 
            temperature: forecast[:current][:temp_f],
            feels_like: forecast[:current][:feelslike_f],
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
              max_temp: daily[:day][:maxtemp_f],
              min_temp: daily[:day][:mintemp_f],
              condition: daily[:day][:condition][:text],
              icon: daily[:day][:condition][:icon]
            }
          end,
          hourly_weather: forecast[:forecast][:forecastday][0][:hour].map do |hourly|
            {
              time: hourly[:time][/\d{2}:\d{2}/],
              temperature: hourly[:temp_f],
              conditions: hourly[:condition][:text],
              icon: hourly[:condition][:icon]
            }
          end
        }
      }
    }
  end
end