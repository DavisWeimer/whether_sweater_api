require 'rails_helper'

RSpec.describe 'Users::RegistrationsController', type: :request do
  describe 'POST /signup' do
    context 'with valid parameters' do
      let(:valid_attributes) { { user: { email: 'test@example.com', password: 'password123', password_confirmation: 'password123' } } }

      it 'creates a new user' do
        expect {
          post '/signup', params: valid_attributes
        }.to change(User, :count).by(1)

        expect(response).to have_http_status(:ok)
        expect(json['status']['message']).to eq('Signed up sucessfully.')
        expect(json['data']['email']).to eq('test@example.com')
      end
    end

    context 'with invalid parameters' do
      let(:invalid_attributes) { { user: { email: '', password: 'password123', password_confirmation: 'password123' } } }

      it 'does not create a new user' do
        expect {
          post '/signup', params: invalid_attributes
        }.not_to change(User, :count)

        expect(response).to have_http_status(:unprocessable_entity)
        expect(json['status']['message']).to include("User couldn't be created successfully")
      end
    end
  end
end

def json
  JSON.parse(response.body)
end