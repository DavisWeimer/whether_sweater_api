# frozen_string_literal: true

class Forecast
  attr_reader :id,
              :type,
              :current_weather,
              :daily_weather,
              :hourly_weather

  def initialize(forecast_data, units = '')
    @id = nil
    @type = 'forecast'
    @units = units
    @forecast_data = forecast_data
    @current_weather = current_weather
    @daily_weather = daily_weather
    @hourly_weather = hourly_weather
  end

  def units_logic
    {
      temperature_key: @units == 'metric' ? :temp_c : :temp_f,
      feels_like_key: @units == 'metric' ? :feelslike_c : :feelslike_f,
      max_temp_key: @units == 'metric' ? :maxtemp_c : :maxtemp_f,
      min_temp_key: @units == 'metric' ? :mintemp_c : :mintemp_f
    }
  end

  def current_weather
    keys = units_logic
    datetime_str = @forecast_data[:current][:last_updated]
    datetime = DateTime.parse(datetime_str)
    formatted_str = datetime.strftime("%b %d %I:%M %p")
    {
      last_updated: formatted_str,
      temperature: @forecast_data[:current][keys[:temperature_key]],
      feels_like: @forecast_data[:current][keys[:feels_like_key]],
      humidity: @forecast_data[:current][:humidity],
      uvi: @forecast_data[:current][:uv],
      visibility: @forecast_data[:current][:vis_miles],
      condition: @forecast_data[:current][:condition][:text],
      icon: @forecast_data[:current][:condition][:icon]
    }
  end

  def daily_weather
    keys = units_logic
    @forecast_data[:forecast][:forecastday].map do |daily|
      date_str = daily[:date]
      date = Date.parse(date_str)
      formatted_str = date.strftime("%a")
      {
        date: formatted_str,
        sunrise: daily[:astro][:sunrise],
        sunset: daily[:astro][:sunset],
        max_temp: daily[:day][keys[:max_temp_key]],
        min_temp: daily[:day][keys[:min_temp_key]],
        condition: daily[:day][:condition][:text],
        icon: daily[:day][:condition][:icon]
      }
    end
  end

  def hourly_weather
    keys = units_logic
    @forecast_data[:forecast][:forecastday][0][:hour].map do |hourly|
      {
        time: hourly[:time][/\d{2}:\d{2}/],
        temperature: hourly[keys[:temperature_key]],
        conditions: hourly[:condition][:text],
        icon: hourly[:condition][:icon]
      }
    end
  end
end
