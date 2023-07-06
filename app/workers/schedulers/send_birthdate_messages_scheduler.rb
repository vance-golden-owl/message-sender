require 'sidekiq-scheduler'

module Schedulers
  class SendBirthdateMessagesScheduler
    include Sidekiq::Worker

    def perform
      users = User.all

      users.find_each do |user|
        uri = URI(ENV['HOOKBIN_ENDPOINT'])

        request = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json')
        request.body = {
          message: "Hey, #{user.full_name} it's your birthday"
        }.to_json

        Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') do |http|
          http.request(request)
        end
      end
    end
  end
end
