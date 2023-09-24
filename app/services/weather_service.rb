class WeatherService
  def self.conn
    @_conn ||= Faraday.new(url: "http://api.weatherapi.com" ) do |faraday|
      faraday.params["key"] = Rails.application.credentials.weather[:key]
    end
  end

  def self.five_days_weather(location_coords)
    response = conn.get do |req|
      req.url "/v1/forecast.json", q: location_coords.values.join(', '), days: 6
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.destination_weather(destination, time)
    response = conn.get do |req|
      req.url "/v1/forecast.json", q: destination.values.join(', '), hour: time
    end
    JSON.parse(response.body, symbolize_names: true)
  end
end