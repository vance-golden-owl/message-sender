module API
  module V1
    module Users
      class RegistrationsController < BaseController
        skip_before_action :authenticate_user!

        def create
          user = Auth::RegisterUserService.call(user_params)
          user.generate_email_verification_token!
          AccountMailer.with(user: user).verification_email.deliver_now
          render_resource(user, view: :auth, status: :created)
        end

        def verify
          user = User.find_by!(email_verification_token: verification_token)
          if user.email_token_expired?
            render_api_error(APIError::NotAuthenticatedError.new('Code is not valid or expired'))
          else
            user.verify_email!
            render_resource(user)
          end
        end

        private

        def user_params
          params.require(:user).permit(:email, :password, :phone_code, :phone_number, :name, :role)
        end

        def verification_token
          params.require(:verification_token)
        end
      end
    end
  end
end
