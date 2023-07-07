require 'rails_helper'

RSpec.describe SendMessageService, type: :service do
  context 'When invoked' do
    it 'post message to Hookbin end-point' do
      stub_request(:post, ENV['HOOKBIN_ENDPOINT']).to_return(status: 200)
      SendMessageService.call('lorem')
    end
  end
end
