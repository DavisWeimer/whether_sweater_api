# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V0::BackgroundsController', type: :request do
  let!(:user) { User.create(email: 'test@example.com', password: 'password123', password_confirmation: 'password123') }

  describe 'GET /api/v0/backgrounds' do
    context 'when authenticated' do
      before do
        post '/login', params: { user: { email: 'test@example.com', password: 'password123' } }
      end

      it 'returns background image data for a valid location', :vcr do
        get '/api/v0/backgrounds', params: { location: 'denver,co' }, headers: { Authorization: token }

        expect(response).to have_http_status(:ok)
        background = JSON.parse(response.body, symbolize_names: true)
        expect(background).to have_key(:data)
        expect(background[:data]).to have_key(:type)
        expect(background[:data][:type]).to eq('image')
        expect(background[:data]).to have_key(:id)
        expect(background[:data][:id]).to eq(nil)
        expect(background[:data]).to have_key(:attributes)
        expect(background[:data][:attributes]).to have_key(:image)
  
        # image
        expect(background[:data][:attributes][:image]).to be_a(Hash)
        expect(background[:data][:attributes][:image]).to have_key(:location)
        expect(background[:data][:attributes][:image][:location]).to be_a(String)
        expect(background[:data][:attributes][:image]).to have_key(:image_url)
        expect(background[:data][:attributes][:image][:image_url]).to be_a(String)
        expect(background[:data][:attributes][:image]).to have_key(:credit)
  
        # credit
        expect(background[:data][:attributes][:image][:credit]).to be_a(Hash)
        expect(background[:data][:attributes][:image][:credit]).to have_key(:source)
        expect(background[:data][:attributes][:image][:credit][:source]).to be_a(String)
        expect(background[:data][:attributes][:image][:credit]).to have_key(:author)
        expect(background[:data][:attributes][:image][:credit][:author]).to be_a(String)
        expect(background[:data][:attributes][:image][:credit]).to have_key(:portfolio)
        expect(background[:data][:attributes][:image][:credit][:portfolio]).to be_a(String).or eq nil
      end
    end

    context 'when not authenticated' do
      it 'returns unauthorized', :vcr do
        get '/api/v0/backgrounds', params: { location: 'denver,co' }

        expect(response).to have_http_status(:unauthorized)
        expect(response.body).to eq("You need to sign in or sign up before continuing.")
      end
    end
  end
end

def json
  JSON.parse(response.body)
end

def token
  response.header["Authorization"]
end


# RSpec.describe 'Backgrounds', type: :request do
#   describe 'GET /show' do
#     it 'return image url and info based on a location parameter', :vcr do
#       get api_v0_backgrounds_path, params: 'location=denver,co',
#                                    headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }

      # background = JSON.parse(response.body, symbolize_names: true)
      # expect(background).to have_key(:data)
      # expect(background[:data]).to have_key(:type)
      # expect(background[:data][:type]).to eq('image')
      # expect(background[:data]).to have_key(:id)
      # expect(background[:data][:id]).to eq(nil)
      # expect(background[:data]).to have_key(:attributes)
      # expect(background[:data][:attributes]).to have_key(:image)

      # # image
      # expect(background[:data][:attributes][:image]).to be_a(Hash)
      # expect(background[:data][:attributes][:image]).to have_key(:location)
      # expect(background[:data][:attributes][:image][:location]).to be_a(String)
      # expect(background[:data][:attributes][:image]).to have_key(:image_url)
      # expect(background[:data][:attributes][:image][:image_url]).to be_a(String)
      # expect(background[:data][:attributes][:image]).to have_key(:credit)

      # # credit
      # expect(background[:data][:attributes][:image][:credit]).to be_a(Hash)
      # expect(background[:data][:attributes][:image][:credit]).to have_key(:source)
      # expect(background[:data][:attributes][:image][:credit][:source]).to be_a(String)
      # expect(background[:data][:attributes][:image][:credit]).to have_key(:author)
      # expect(background[:data][:attributes][:image][:credit][:author]).to be_a(String)
      # expect(background[:data][:attributes][:image][:credit]).to have_key(:portfolio)
      # expect(background[:data][:attributes][:image][:credit][:portfolio]).to be_a(String).or eq nil
#     end
#   end
# end
