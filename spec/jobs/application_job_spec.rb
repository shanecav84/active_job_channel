require 'spec_helper'

RSpec.describe ApplicationJob do
  it 'broadcasts success' do
    job_id = 123
    allow_any_instance_of(described_class).
      to receive(:job_id).
      and_return(job_id)
    expect(::PendantChannel).
      to receive(:broadcast_to).
      with('pendant_channel', status: 'success', job_id: job_id)
    described_class.perform_now
  end

  it 'broadcasts failure' do
    job_id = 123
    allow_any_instance_of(described_class).
      to receive(:fake).
      and_raise(::StandardError)
    allow_any_instance_of(described_class).
      to receive(:job_id).
      and_return(job_id)
    expect(::PendantChannel).
      to receive(:broadcast_to).
      with('pendant_channel', status: 'failure', job_id: job_id)
    expect { described_class.perform_now }.to raise_error(::StandardError)
  end
end
