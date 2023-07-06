module API
  module V1
    class UsersController < BaseController
      before_action :prepare_user, only: %i[show update destroy]

      def create
        user = User.new(user_params)
        authorize(user)
        user.save!

        render_resource(user)
      end

      def show
        render_resource(@user)
      end

      def update
        @user.update!(user_params)

        render_resource(@user)
      end

      def destroy
        @user.destroy

        head :no_content
      end

      private

      def prepare_user
        @user = User.find(params[:id])
        authorize(@user)
      end

      def user_params
        pr = params.require(:user).permit(
          :first_name,
          :last_name,
          :birthdate,
          :address
        )
        pr[:birthdate] = EpochConverter.to_datetime(pr[:birthdate]) if pr[:birthdate]
        pr
      end
    end
  end
end
