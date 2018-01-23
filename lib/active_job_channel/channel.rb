module ActiveJobChannel
  class Channel < ::ActionCable::Channel::Base
    CHANNEL_NAME = 'active_job_channel'.freeze

    def subscribed
      stream_from CHANNEL_NAME
      stream_from private_stream if connection.connection_identifier.present?
    end

    private

    def private_stream
      [CHANNEL_NAME, connection.connection_identifier].join('#')
    end
  end
end
