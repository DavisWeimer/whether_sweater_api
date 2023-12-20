require 'rails_helper'

RSpec.describe 'Authentication', type: :request do
  describe 'POST /login' do
    let!(:user) { User.create!(email: 'test@example.com', password: 'password123', password_confirmation: 'password123') }

    it 'dispatches a JWT token upon successful login' do
      post '/login', params: { user: { email: 'test@example.com', password: 'password123' } }
      expect(response).to have_http_status(:success)
      token = response.headers['Authorization'].split(' ').last
      expect(token).not_to be_nil
    end
  end
end