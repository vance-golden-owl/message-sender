require 'sidekiq-scheduler'

module Schedulers
  class SendBirthdateMessagesScheduler
    include Sidekiq::Worker

    def perform
      users = User.today_birthday

      users.find_each do |user|
        message = "Hey, #{user.full_name} it's your birthday"
        time_to_send = generate_send_time(user.timezone_name)

        SendMessageJob.set(wait_until: time_to_send).perform_later(message)
      end
    end

    private

    def generate_send_time(timezone_name)
      local_time = Time.find_zone(timezone_name)
      day = local_time.now.day
      month = local_time.now.month
      year = local_time.now.year
      send_time = local_time.local(year, month, day, 9)

      return send_time unless send_time < Time.current.beginning_of_day

      send_time + 1.day
    end
  end
end
