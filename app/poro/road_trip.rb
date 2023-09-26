class RoadTrip
  attr_reader :id, 
              :type, 
              :start_city, 
              :end_city, 
              :travel_time,
              :weather_at_eta

  def initialize(start, finish, time, forecast)
    @id = nil
    @type = "road_trip"
    @start_city = start
    @end_city = finish
    @travel_time = time
    @weather_at_eta = forecast
  end
end