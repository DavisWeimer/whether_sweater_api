class UserSerializer
  def self.format_user(user, api_key)
    {
      type: "users",
      id: user.id,
      attributes: {
        email: user.email,
        api_key: api_key
      }
    }
  end
end
