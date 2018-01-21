require 'spec_helper'

module ActiveJobChannel
  module Broadcaster
    RSpec.describe ClassMethods do
      before(:each) do
        class DummyJob < ::ActiveJob::Base
          active_job_channel global_broadcast: true
          def perform
            fake
          end

          private

          def fake; end
        end
        DummyJob.extend(described_class)
      end

      describe '.active_job_channel' do
        it 'sets ajc_config with options hash' do
          DummyJob.active_job_channel
          expect(DummyJob.ajc_config).to eq(global_broadcast: false)

          DummyJob.active_job_channel global_broadcast: true
          expect(DummyJob.ajc_config).to eq(global_broadcast: true)
        end
      end

      describe '#broadcast_failure' do
        it 'handles an error' do
          allow_any_instance_of(DummyJob).
            to receive(:fake).
            and_raise(StandardError)
          allow_any_instance_of(DummyJob).
            to receive(:serialize).
            and_return({})
          expect_any_instance_of(DummyJob).
            to receive(:broadcast_failure).
            with(StandardError).
            and_call_original

          action_cable_server = double 'action_cable_server'
          allow(ActionCable).to receive(:server).and_return(action_cable_server)
          expect(action_cable_server).
            to receive(:broadcast).
            with(
              ::ActiveJobChannel::Channel::CHANNEL_NAME,
              status: 'failure',
              data: {},
              error: StandardError.new.inspect
            )

          expect { DummyJob.perform_now }.to raise_error(StandardError)
        end

        context 'with ajc_identifier' do
          it 'broadcast failure to the identifier' do
            DummyJob.active_job_channel global_broadcast: false
            ajc_identifier = 'ajc_identifier'
            allow_any_instance_of(DummyJob).
              to receive(:fake).
              and_raise(StandardError)
            allow_any_instance_of(DummyJob).
              to receive(:ajc_identifier).
              and_return(ajc_identifier)
            allow_any_instance_of(DummyJob).
              to receive(:serialize).
              and_return({})
            expect_any_instance_of(DummyJob).
              to receive(:broadcast_failure).
              with(StandardError).
              and_call_original

            action_cable_server = double 'action_cable_server'
            allow(ActionCable).
              to receive(:server).
              and_return(action_cable_server)
            expect(action_cable_server).
              to receive(:broadcast).
              with(
                "#{::ActiveJobChannel::Channel::CHANNEL_NAME}#" \
                  "#{ajc_identifier}",
                status: 'failure',
                data: {},
                error: StandardError.new.inspect
              )

            expect { DummyJob.perform_now }.to raise_error(StandardError)
          end
        end
      end

      describe '#broadcast_success' do
        it 'broadcasts' do
          expect_any_instance_of(DummyJob).
            to receive(:broadcast_success).
            and_call_original
          allow_any_instance_of(DummyJob).
            to receive(:serialize).
            and_return({})

          action_cable_server = double 'action_cable_server'
          allow(ActionCable).to receive(:server).and_return(action_cable_server)
          expect(action_cable_server).
            to receive(:broadcast).
            with(
              ::ActiveJobChannel::Channel::CHANNEL_NAME,
              status: 'success',
              data: {}
            )

          DummyJob.perform_now
        end
      end

      describe 'ajc_identifier' do
        it 'broadcasts success to the identifier' do
          DummyJob.active_job_channel global_broadcast: false
          ajc_identifier = 'ajc_identifier'
          allow_any_instance_of(DummyJob).
            to receive(:ajc_identifier).
            and_return(ajc_identifier)
          allow_any_instance_of(DummyJob).
            to receive(:serialize).
            and_return({})
          expect_any_instance_of(DummyJob).
            to receive(:broadcast_success).
            and_call_original

          action_cable_server = double 'action_cable_server'
          allow(ActionCable).
            to receive(:server).
            and_return(action_cable_server)
          expect(action_cable_server).
            to receive(:broadcast).
            with(
              "#{::ActiveJobChannel::Channel::CHANNEL_NAME}#" \
                "#{ajc_identifier}",
              status: 'success',
              data: {}
            )

          DummyJob.perform_now
        end

        it 'must not be set for a global broadcast' do
          DummyJob.active_job_channel global_broadcast: true
          allow_any_instance_of(DummyJob).
            to receive(:ajc_identifier).
            and_return('ajc_identifier')
          expect { DummyJob.perform_now }.
            to raise_error(::ActiveJobChannel::UnnecessaryIdentifierError).
            with_message(/DummyJob/)
        end

        it 'must be set for a private broadcast' do
          DummyJob.active_job_channel global_broadcast: false
          expect { DummyJob.perform_now }.
            to raise_error(::ActiveJobChannel::NoIdentifierError).
            with_message(/DummyJob/)
        end
      end
    end
  end
end
