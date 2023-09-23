require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "POST /create" do
    it "creates a User from request", :vcr do
      user_request = {
        "email": "whatever@example.com",
        "password": "password",
        "password_confirmation": "password"
      }
      
      post api_v0_users_path, params: user_request.to_json, headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }


    end
  end
end