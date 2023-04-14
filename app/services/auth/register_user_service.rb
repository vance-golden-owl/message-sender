module Auth
  class RegisterUserService < ApplicationService
    attr_reader :params, :role

    def initialize(params)
      @params = params.except(:role)
      @role = params[:role]
    end

    def call
      user = User.create!(params)
      case role
      when 'shop_owner'
        user.add_role :shop_owner
      end
      user
    end
  end
end
