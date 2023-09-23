require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "POST /create" do
    it "creates a User from request", :vcr do
      user_request = {
        user: {
          email: "whatever@example.com",
          password: "password",
          password_confirmation: "password"
        }
      }
      
      post api_v0_users_path, params: user_request.to_json, headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }

      expect(response).to have_http_status(:created)

      user = JSON.parse(response.body, symbolize_names: true)

      expect(user).to have_key(:data)
      expect(user[:data]).to have_key(:type)
      expect(user[:data]).to have_key(:id)
      expect(user[:data]).to have_key(:attributes)
      expect(user[:data][:type]).to eq("users")
      expect(user[:data][:attributes]).to have_key(:email)
      expect(user[:data][:attributes][:email]).to be_a(String)
      expect(user[:data][:attributes]).to have_key(:api_key)
      expect(user[:data][:attributes][:api_key]).to be_a(String)
      expect(user[:data][:attributes]).not_to have_key(:password)
    end

    xit "returns status and error message on unsuccessful request", :vcr do
      user_request = {
        user: {
          email: "existing@example.com", 
          password: "yoooooooooo123",
          password_confirmation: "yoooooooooo123"
        }
      }

      post api_v0_users_path, params: user_request.to_json, headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }

      invalid_user_request = {
        user: {
          email: "existing@example.com", 
          password: "password",
          password_confirmation: "password"
        }
      }

      post api_v0_users_path, params: invalid_user_request.to_json, headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.content_type).to include('application/json')

      response_json = JSON.parse(response.body)

      expect(response_json).to have_key('errors')
    end
  end
end