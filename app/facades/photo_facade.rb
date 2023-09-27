# frozen_string_literal: true

class PhotoFacade
  def self.photos_by_location_title(location)
    photo_data = PhotoService.find_photos_by_location_title(location)[:results].sample
    Photo.new(photo_data, location)
  end
end
