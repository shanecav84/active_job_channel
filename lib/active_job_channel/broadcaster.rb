module ActiveJobChannel
  module Broadcaster
    module ClassMethods
      def active_job_channel(options = {})
        class_attribute :ajc_config
        self.ajc_config = { global_broadcast: false }
        self.ajc_config.merge!(options)

        after_perform :broadcast_success
        rescue_from '::StandardError' do |exception|
          broadcast_failure
          raise exception
        end

        include ActiveJobChannel::Broadcaster::InstanceMethods
      end
    end

    module InstanceMethods
      private

      attr_accessor :ajc_identifier

      def broadcast_failure
        ActionCable.server.broadcast(
          ajc_channel_name,
          status: 'failure',
          job_name: self.class.to_s
        )
      end

      def broadcast_success
        ActionCable.server.broadcast(
          ajc_channel_name,
          status: 'success',
          job_name: self.class.to_s
        )
      end

      def ajc_channel_name
        if ajc_config[:global_broadcast]
          ::ActiveJobChannel::Channel::CHANNEL_NAME
        else
          [::ActiveJobChannel::Channel::CHANNEL_NAME, ajc_identifier].
            compact.
            join('#')
        end
      end
    end
  end
end
