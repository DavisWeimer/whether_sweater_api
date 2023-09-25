# frozen_string_literal: true

class LocationFacade
  def self.location_coordinates(location)
    LocationService.find_location_coordinates(location)[:results].map do |location_data|
      {
        lat: location_data[:locations][0][:latLng][:lat],
        lng: location_data[:locations][0][:latLng][:lng]
      }
    end.first
  end

  def self.road_trip_travel_time(start, finish)
    time = LocationService.find_road_trip_travel_time(start, finish)
    if time[:route].key?(:sessionId)
      time[:route][:formattedTime]
    else
      'Impossible'
    end
  end
end
