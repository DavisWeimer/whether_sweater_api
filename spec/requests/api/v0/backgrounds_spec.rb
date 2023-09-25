require 'rails_helper'

RSpec.describe "Backgrounds", type: :request do
  describe "GET /show" do
    it "return image url and info based on a location parameter", :vcr do
      get api_v0_backgrounds_path, params: "location=denver,co", headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }

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
      expect(background[:data][:attributes][:image][:credit][:portfolio]).to be_a(String)
    end 
  end
end
