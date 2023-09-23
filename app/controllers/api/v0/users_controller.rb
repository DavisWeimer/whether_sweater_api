class Api::V0::UsersController < ApplicationController
  def create
    user = User.new(user_params)
    if user.save
      api_key = api_key_gen(user)
      render json: { data: UserSerializer.format_user(user, api_key) }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def api_key_gen(user)
    require 'pry'; binding.pry
    api_key = SecureRandom.hex(32)
    user.update(api_key: api_key)
    api_key
  end
end