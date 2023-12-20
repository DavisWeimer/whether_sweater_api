# frozen_string_literal: true

# spec/requests/users/sessions_controller_spec.rb

require 'rails_helper'

RSpec.describe 'Users::SessionsController', type: :request do
  let!(:user) { User.create(email: 'test@example.com', password: 'password123', password_confirmation: 'password123') }

  describe 'POST /login' do
    context 'with valid credentials' do
      it 'logs in the user' do
        post '/login', params: { user: { email: 'test@example.com', password: 'password123' } }
        expect(response).to have_http_status(:ok)
        expect(json['status']['message']).to eq('Logged in sucessfully.')
        expect(json['data']['email']).to eq('test@example.com')
      end
    end

    context 'with invalid credentials' do
      it 'does not log in the user' do
        post '/login', params: { user: { email: 'test@example.com', password: 'wrong_password' } }
        expect(response).to have_http_status(:unauthorized)
        expect(response.body).to eq("Invalid Email or password.")
      end
    end
  end

  describe 'DELETE /logout' do
    it 'logs out the user' do
      post '/login', params: { user: { email: 'test@example.com', password: 'password123' } }
      delete '/logout', headers: { Authorization: token }
      expect(response).to have_http_status(:ok)
      expect(json['status']).to eq(200)
      expect(json['message']).to eq('Logged out successfully.')
    end
  end
end

def json
  JSON.parse(response.body)
end

def token
  response.header["Authorization"]
end
