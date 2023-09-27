# frozen_string_literal: true

class PhotoSerializer
  include JSONAPI::Serializer
  set_type 'image'
  attributes :image
end
