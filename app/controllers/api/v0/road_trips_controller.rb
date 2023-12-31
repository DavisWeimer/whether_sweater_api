# frozen_string_literal: true

module Api
  module V0
    class RoadTripsController < ApplicationController
      def create
        unless road_trip_params[:origin].present? && road_trip_params[:destination].present?
          render json: { error: 'Missing parameters' }, status: :unprocessable_entity
          return
        end

        road_trip = RoadTripFacade.road_trip_create(road_trip_params)
        
        render json: RoadTripSerializer.new(road_trip),
               status: :ok
      end

      private

      def road_trip_params
        params.require(:road_trip).permit(:origin, :destination, :units)
      end
    end
  end
end
