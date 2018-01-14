module ActiveJobChannel
  class Channel < ::ActionCable::Channel::Base
    CHANNEL_NAME = 'active_job_channel'.freeze

    def subscribed
      stream_from channel_name
    end

    private

    def channel_name
      [CHANNEL_NAME, connection.connection_identifier].compact.join('#')
    end
  end
end
