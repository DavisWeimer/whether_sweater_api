# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'POST /create' do
    it 'creates a User from request', :vcr do
      user_request = {
        email: 'whatever@example.com',
        password: 'password',
        password_confirmation: 'password'
      }

      post api_v0_users_path, params: user_request.to_json,
                              headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }
      expect(response).to have_http_status(:created)

      user = JSON.parse(response.body, symbolize_names: true)
      expect(user).to have_key(:data)
      expect(user[:data]).to have_key(:type)
      expect(user[:data]).to have_key(:id)
      expect(user[:data]).to have_key(:attributes)
      expect(user[:data][:type]).to eq('user')
      expect(user[:data][:attributes]).to have_key(:email)
      expect(user[:data][:attributes][:email]).to be_a(String)
      expect(user[:data][:attributes]).to have_key(:api_key)
      expect(user[:data][:attributes][:api_key]).to be_a(String)
      expect(user[:data][:attributes]).not_to have_key(:password)
    end

    it "returns status and error message when email already exists and/or passwords don't match", :vcr do
      user_request = {
        email: 'existing@example.com',
        password: 'yoooooooooo123',
        password_confirmation: 'yoooooooooo123'
      }

      post api_v0_users_path, params: user_request.to_json,
                              headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }

      invalid_user_request = {
        email: 'existing@example.com',
        password: 'password',
        password_confirmation: 'wuuuuuuuawhaowudh'
      }

      post api_v0_users_path, params: invalid_user_request.to_json,
                              headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }
      expect(response).to have_http_status(:unprocessable_entity)

      error = JSON.parse(response.body, symbolize_names: true)
      expect(error).to have_key(:errors)
      expect(error[:errors][0]).to eq('Email has already been taken')
      expect(error[:errors][1]).to eq("Password confirmation doesn't match Password")
    end
  end
end
