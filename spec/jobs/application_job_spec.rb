require 'spec_helper'

RSpec.describe ApplicationJob do
  it 'broadcasts success' do
    expect(::ActiveJobNotifierChannel).
      to receive(:broadcast_to).
      with('active_job_notifier_channel', status: 'success', job_name: 'Job Name')
    described_class.perform_now
  end

  it 'broadcasts failure' do
    allow_any_instance_of(described_class).
      to receive(:fake).
      and_raise(::StandardError)
    expect(::ActiveJobNotifierChannel).
      to receive(:broadcast_to).
      with('active_job_notifier_channel', status: 'failure', job_name: 'Job Name')
    expect { described_class.perform_now }.to raise_error(::StandardError)
  end

  it 'broadcasts the job name' do
    expect(::ActiveJobNotifierChannel).
      to receive(:broadcast_to).
      with('active_job_notifier_channel', status: 'success', job_name: 'Job Name')
    described_class.perform_now
  end
end
