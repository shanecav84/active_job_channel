require 'active_job_channel'

module ActiveJobChannel
  module Broadcaster
    module ClassMethods
      def active_job_channel(options = {})
        class_attribute :ajc_config
        self.ajc_config = { global_broadcast: false }
        ajc_config.merge!(options)

        after_perform :broadcast_success
        rescue_from '::StandardError' do |exception|
          broadcast_failure(exception)
          raise exception
        end

        include ActiveJobChannel::Broadcaster::InstanceMethods
      end
    end

    module InstanceMethods
      private

      attr_writer :ajc_identifier

      def ajc_channel_name
        if ajc_config[:global_broadcast]
          if ajc_identifier.present?
            raise UnnecessaryIdentifierError, self.class.to_s
          end

          ::ActiveJobChannel::Channel::CHANNEL_NAME
        else
          [::ActiveJobChannel::Channel::CHANNEL_NAME, ajc_identifier].
            compact.
            join('#')
        end
      end

      def ajc_identifier
        if ajc_identifier_missing?
          raise ::ActiveJobChannel::NoIdentifierError, self.class.to_s
        end

        @ajc_identifier
      end

      def ajc_identifier_missing?
        !ajc_config[:global_broadcast] && @ajc_identifier.nil?
      end

      def broadcast_failure(exception)
        ActionCable.server.broadcast(
          ajc_channel_name,
          status: 'failure',
          data: serialize,
          error: exception.inspect
        )
      end

      def broadcast_success
        ActionCable.server.broadcast(
          ajc_channel_name,
          status: 'success',
          data: serialize
        )
      end
    end
  end
end
