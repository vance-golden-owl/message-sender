module Auth
  class Google
    def authenticate(user_params)
      email = user_params[:email]
      google_uid = user_params[:google_uid]
      user = User.find_by(google_uid: google_uid, email: email)

      if user.nil?
        user = User.create!(
          name: Faker::FunnyName.name,
          email: email,
          password: SecureRandom.hex(20),
          google_uid: google_uid
        )
      end

      user
    end
  end
end
