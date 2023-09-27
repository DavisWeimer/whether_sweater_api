# frozen_string_literal: true

module Api
  module V0
    class BackgroundsController < ApplicationController
      def index
        background = PhotoFacade.photos_by_location_title(params[:location])
        render json: PhotoSerializer.new(background)
      end
    end
  end
end
