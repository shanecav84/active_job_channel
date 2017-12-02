module ActiveJobChannel
  class Channel < ::ActionCable::Channel::Base
    def subscribed
      stream_for 'active_job_channel'
    end
  end
end
