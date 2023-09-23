class User < ApplicationRecord
  before_create :api_key_gen

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, confirmation: true

  has_secure_password


  private

  def api_key_gen
    self.api_key = SecureRandom.hex(32)
  end
end
