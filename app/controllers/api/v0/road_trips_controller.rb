# frozen_string_literal: true

module Api
  module V0
    class RoadTripsController < ApplicationController
      def create
        unless road_trip_params[:origin].present? && road_trip_params[:destination].present? && road_trip_params[:api_key].present?
          render json: { error: 'Missing parameters' }, status: :unprocessable_entity
          return
        end

        user = User.find_by(api_key: road_trip_params[:api_key])
        unless user
          render json: { error: 'Unauthorized' }, status: :unauthorized
          return
        end
        
        road_trip = RoadTripFacade.road_trip_create(road_trip_params)
        
        render json: RoadTripSerializer.new(road_trip),
               status: :ok
      end

      private

      def road_trip_params
        params.permit(:origin, :destination, :api_key, :units)
      end
    end
  end
end
