# frozen_string_literal: true

class AddColumnsToForecast < ActiveRecord::Migration[7.0]
  def change
    add_column :forecasts, :current_weather, :json
    add_column :forecasts, :daily_weather, :jsonb
    add_column :forecasts, :hourly_weather, :jsonb
  end
end
