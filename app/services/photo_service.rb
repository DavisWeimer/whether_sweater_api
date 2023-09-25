# frozen_string_literal: true

class PhotoService
  def self.conn
    @conn ||= Faraday.new(url: 'https://api.unsplash.com') do |faraday|
      faraday.params['client_id'] = Rails.application.credentials.unsplash[:access_key]
    end
  end

  def self.find_photos_by_location_title(location)
    Rails.cache.fetch("backgrounds:#{location}", expires_in: 12.hours) do
      response = conn.get do |req|
        req.url('search/photos', query: "daytime,cityscape,#{location}", orientation: 'landscape')
      end
      JSON.parse(response.body, symbolize_names: true)
    end
  end
end
