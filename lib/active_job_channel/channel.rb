module ActiveJobChannel
  class Channel < ::ActionCable::Channel::Base
    def subscribed
      stream_from 'active_job_channel'
    end
  end
end
