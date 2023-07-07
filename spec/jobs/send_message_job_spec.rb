require 'rails_helper'

RSpec.describe SendMessageJob, type: :job do
  context 'when called' do
    let(:send_message_service) { instance_double(SendMessageService) }

    it 'enqueue sucessfully' do
      allow(send_message_service).to receive(:call)

      expect do
        SendMessageJob.perform_later('lorem')
      end.to have_enqueued_job(SendMessageJob)
    end
  end
end
