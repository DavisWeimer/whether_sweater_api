require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "POST /login" do 
    it "returns user email/token if they exist", :vcr do
      user = User.create(email: "yoyoyoyoy@example.com",
                          password: "password", 
                          password_confirmation: "password", 
                          api_key: "640560c67845c6d6f9bb0a3d3ff7c4805c721c6cc659aac0c35be848674e4b00")
      user_login = {
        "email": user.email,
        "password": user.password
      }
      require 'pry'; binding.pry
      post api_v0_sessions_path
    end
  end
end