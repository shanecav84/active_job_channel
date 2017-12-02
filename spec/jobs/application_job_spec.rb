require 'spec_helper'

RSpec.describe ApplicationJob do
  it 'broadcasts success' do
    expect(::ActiveJobChannel::Channel).
      to receive(:broadcast_to).
      with('active_job_channel', status: 'success', job_name: 'ApplicationJob')
    described_class.perform_now
  end

  it 'broadcasts failure' do
    allow_any_instance_of(described_class).
      to receive(:fake).
      and_raise(::StandardError)
    expect(::ActiveJobChannel::Channel).
      to receive(:broadcast_to).
      with('active_job_channel', status: 'failure', job_name: 'ApplicationJob')
    expect { described_class.perform_now }.to raise_error(::StandardError)
  end

  it 'broadcasts the job name' do
    expect(::ActiveJobChannel::Channel).
      to receive(:broadcast_to).
      with('active_job_channel', status: 'success', job_name: 'ApplicationJob')
    described_class.perform_now
  end
end
