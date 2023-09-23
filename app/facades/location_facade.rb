class LocationFacade
  def self.location_coordinates(location)
    LocationService.find_location_coordinates(location)[:results].map do |location_data|
      {
        lat: location_data[:locations][0][:latLng][:lat],
        lng: location_data[:locations][0][:latLng][:lng]
      }
    end.first
  end
end