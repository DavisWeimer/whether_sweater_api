class PhotoFacade
  def self.photos_by_location_title(location)
    PhotoService.find_photos_by_location_title(location)
  end
end