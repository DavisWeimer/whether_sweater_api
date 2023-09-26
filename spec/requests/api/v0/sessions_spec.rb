# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'POST /login' do
    it 'returns user email/token if they exist', :vcr do
      user = User.create(email: 'yoyoyoyoy@example.com',
                         password: 'password',
                         password_confirmation: 'password',
                         api_key: '640560c67845c6d6f9bb0a3d3ff7c4805c721c6cc659aac0c35be848674e4b00')
      user_login = {
        "email": user.email,
        "password": user.password
      }
      post api_v0_sessions_path, params: user_login.to_json,
                                 headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }
      expect(response).to have_http_status(:ok)

      session = JSON.parse(response.body, symbolize_names: true)
      expect(session).to have_key(:data)
      expect(session[:data]).to have_key(:type)
      expect(session[:data]).to have_key(:id)
      expect(session[:data]).to have_key(:attributes)
      expect(session[:data][:type]).to eq('user')
      expect(session[:data][:attributes]).to have_key(:email)
      expect(session[:data][:attributes][:email]).to be_a(String)
      expect(session[:data][:attributes]).to have_key(:api_key)
      expect(session[:data][:attributes][:api_key]).to be_a(String)
      expect(session[:data][:attributes]).not_to have_key(:password)
    end

    it 'returns appropriate status and error message on unsuccessful login', :vcr do
      login_params = {
        email: 'nonexistent@example.com',
        password: 'password'
      }

      post api_v0_sessions_path, params: login_params.to_json,
                                 headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }
      expect(response).to have_http_status(:unauthorized)

      error = JSON.parse(response.body, symbolize_names: true)
      expect(error).to have_key(:errors)
      expect(error[:errors]).to eq('Invalid email or password')
    end
  end
end
