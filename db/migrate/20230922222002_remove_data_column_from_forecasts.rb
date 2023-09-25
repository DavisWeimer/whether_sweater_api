# frozen_string_literal: true

class RemoveDataColumnFromForecasts < ActiveRecord::Migration[7.0]
  def change
    remove_column :forecasts, :data
  end
end
