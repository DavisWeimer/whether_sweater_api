# frozen_string_literal: true

class Photo
  attr_reader :id,
              :type,
              :image

  def initialize(photo_data, location)
    @id = nil
    @type = 'image'
    @image = { location:, image_url: photo_data[:urls][:raw], credit: {
      source: photo_data[:links][:html],
      author: photo_data[:user][:name],
      portfolio: photo_data[:user][:portfolio_url]
    } }
  end
end
