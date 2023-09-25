class PhotoSerializer
  def self.format_photo(photos, location)
    random_photo = photos[:results].sample
    {
      data: {
        type: "image",
        id: nil,
        attributes: {
          image: {
            location: location,
            image_url: random_photo[:urls][:raw],
            credit: {
              source: random_photo[:links][:html],
              author: random_photo[:user][:name],
              portfolio: random_photo[:user][:portfolio_url]
            }
          }
        }
      }
    }
  end
end