class CreateForecasts < ActiveRecord::Migration[7.0]
  def change
    create_table :forecasts do |t|
      t.jsonb :data, default: Hash.new
      t.timestamps
    end
  end
end
