module Auth
  class Local
    def authenticate(user_params)
      email = user_params[:email]
      password = user_params[:password]
      user = User.find_by(email: email)
      user&.authenticate(password) || raise(APIError::NotAuthenticatedError, 'Invalid email or password')
    end
  end
end
