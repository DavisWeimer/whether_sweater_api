# frozen_string_literal: true

class LocationService
  def self.conn
    @conn ||= Faraday.new(url: 'https://www.mapquestapi.com') do |faraday|
      faraday.params['key'] = Rails.application.credentials.map_quest[:key]
    end
  end

  def self.find_location_coordinates(location)
    Rails.cache.fetch("location_#{location}", expires_in: 12.hours) do
      response = conn.get do |req|
        req.url('geocoding/v1/address', location:)
      end
      JSON.parse(response.body, symbolize_names: true)
    end
  end

  def self.find_road_trip_travel_time(start, finish)
    response = conn.get('directions/v2/route') do |req|
      req.url 'directions/v2/route', from: start, to: finish
    end
    JSON.parse(response.body, symbolize_names: true)
  end
end
