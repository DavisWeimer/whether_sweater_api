class RoadTripFacade
  def self.road_trip_create(road_trip_params)
    road_trip_time = LocationFacade.road_trip_travel_time(road_trip_params[:origin], road_trip_params[:destination])

    if road_trip_time == 'Impossible'
      forecast = 'N/A'
    else
      arrival_hour = arrival_time_hour(road_trip_time)
      destination_coords = LocationFacade.location_coordinates(road_trip_params[:destination])
      forecast = WeatherFacade.get_destination_weather(destination_coords, arrival_hour, road_trip_params[:units])
    end

    travel_time = arrival_time_parse(road_trip_time)
    road_trip = RoadTrip.new(road_trip_params[:origin], road_trip_params[:destination], travel_time, forecast)
  end

  private

  def self.arrival_time_parse(time)
    hours, minutes = time.split(':').map(&:to_i)
    hour_pluralization = hours == 1 ? 'hr' : 'hrs'
    minutes_pluralization = minutes == 1 ? 'min' : 'mins'
    "#{hours} #{hour_pluralization} #{minutes} #{minutes_pluralization}"
  end

  def self.arrival_time_hour(time)
    hours, minutes = time.split(':').map(&:to_i)
    Time.now.advance(hours:, minutes:).hour
    
  end
end