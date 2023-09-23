class WeatherFacade
  def self.get_weather_5_days(location_coords)
    WeatherService.five_days_weather(location_coords).map do |weather_data|
      require 'pry'; binding.pry
    end
  end
end