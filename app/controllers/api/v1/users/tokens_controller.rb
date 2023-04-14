module API
  module V1
    module Users
      class TokensController < BaseController
        def refresh
          render_resource(current_user, view: :auth)
        end
      end
    end
  end
end
