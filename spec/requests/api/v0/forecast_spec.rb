require 'rails_helper'

RSpec.describe "Forecasts", type: :request do
  describe "GET /index" do
    it "retrieves weather for a city", :vcr do
      get api_v0_forecast_path("cincinatti,oh")

      expect(response).to be_successful
    end
  end
end
