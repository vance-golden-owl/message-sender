module Auth
  class Apple
    def authenticate(user_params)
      email = user_params[:email]
      apple_uid = user_params[:apple_uid]
      user = User.find_by(apple_uid: apple_uid, email: email)

      if user.nil?
        user = User.create!(
          name: Faker::FunnyName.name,
          email: email,
          password: SecureRandom.hex(20),
          apple_uid: apple_uid
        )
      end

      user
    end
  end
end
