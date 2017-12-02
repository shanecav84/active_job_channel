module ActiveJobChannel
  module Broadcaster
    module ClassMethods
      def active_job_channel
        after_perform :broadcast_success
        rescue_from '::StandardError' do |exception|
          broadcast_failure
          raise exception
        end

        include ActiveJobChannel::Broadcaster::InstanceMethods
      end
    end

    module InstanceMethods
      def broadcast_failure
        ActiveJobChannel::Channel.broadcast_to(
          'active_job_channel',
          status: 'failure',
          job_name: self.class.to_s
        )
      end

      def broadcast_success
        ActiveJobChannel::Channel.broadcast_to(
          'active_job_channel',
          status: 'success',
          job_name: self.class.to_s
        )
      end
    end
  end
end
