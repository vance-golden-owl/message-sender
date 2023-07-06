class ApplicationController < ActionController::API
  include Pundit::Authorization
  include Pagy::Backend

  include ExceptionFilter
  include JSONAPIRender

  attr_reader :current_user
end
