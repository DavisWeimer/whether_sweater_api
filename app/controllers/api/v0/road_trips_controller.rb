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

        road_trip_time = LocationFacade.road_trip_travel_time(road_trip_params[:origin], road_trip_params[:destination])

        if road_trip_time == 'Impossible'
          forecast = 'N/A'
        else
          arrival_hour = arrival_time_hour(road_trip_time)
          destination_coords = LocationFacade.location_coordinates(road_trip_params[:destination])
          forecast = WeatherFacade.get_destination_weather(destination_coords, arrival_hour, params[:units])
        end

        road_trip = RoadTrip.new(road_trip_params[:origin], road_trip_params[:destination], road_trip_time, forecast)
        render json: RoadTripSerializer.new(road_trip),
               status: :ok
      end

      private

      def road_trip_params
        params.permit(:origin, :destination, :api_key, :units)
      end

      def arrival_time_hour(time)
        hours, minutes = time.split(':').map(&:to_i)
        Time.now.advance(hours:, minutes:).hour
      end
    end
  end
end
