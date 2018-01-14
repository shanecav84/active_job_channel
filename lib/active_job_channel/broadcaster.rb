module ActiveJobChannel
  module Broadcaster
    class NoIdentifierError < NameError
      MESSAGE = 'ActiveJobChannel expects an ActionCable Connection ' \
        'identifier to broadcast to. The identifier should be made available ' \
        'in your job via a method or an instance variable, either named ' \
        '`ajc_identifier`. For details about setting up an identifier in ' \
        'your ActionCable Connection, visit http://guides.rubyonrails.org/' \
        "action_cable_overview.html#connection-setup\n\nTo broadcast " \
        'globally without an identifier, pass in ' \
        '`{ global_broadcast: true } ` to `active_job_channel` as part of an ' \
        'options hash.'.freeze

      def initialize(msg = MESSAGE)
        super
      end
    end

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

      attr_writer :ajc_identifier

      def ajc_identifier
        raise NoIdentifierError if ajc_identifier_missing?
        @ajc_identifier
      end

      def ajc_identifier_missing?
        !ajc_config[:global_broadcast] && @ajc_identifier.nil?
      end

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
