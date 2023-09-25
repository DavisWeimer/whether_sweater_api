# frozen_string_literal: true

class RoadTripsSerializer
  def self.format_road_trip(start, finish, travel_time, weather)
    {
      data: {
        id: 'null',
        type: 'road_trip',
        attributes: {
          start_city: start,
          end_city: finish,
          travel_time:,
          weather_at_eta: weather
        }
      }
    }
  end
end
