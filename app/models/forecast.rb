class Forecast < ApplicationRecord
  validates :current_weather, :daily_weather, :hourly_weather, presence: true
end
