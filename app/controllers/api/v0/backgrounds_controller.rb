class Api::V0::BackgroundsController < ApplicationController
  def index
    backgrounds = PhotoFacade.photos_by_location_title(params[:location])

    render json: PhotoSerializer.format_photo(backgrounds, params[:location])
  end
end
