module Auth
  class LoginUserService < ApplicationService
    attr_reader :user_params, :strategy

    def initialize(user_params, strategy)
      @user_params = user_params
      @strategy = strategy
    end

    def call
      strategy.authenticate(user_params)
    end
  end
end
