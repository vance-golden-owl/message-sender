class SendMessageService < ApplicationService
  attr_reader :message

  def initialize(message)
    @message = message
  end

  def call
    uri = URI(ENV['HOOKBIN_ENDPOINT'])

    request = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json')
    request.body = {
      message: message
    }.to_json

    Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') do |http|
      http.request(request)
    end
  end
end
