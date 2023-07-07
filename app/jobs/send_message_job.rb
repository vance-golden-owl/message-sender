class SendMessageJob < ApplicationJob
  queue_as :default

  def perform(message)
    SendMessageService.call(message)
  end
end
