class PendantChannel < ::ActionCable::Channel::Base
  def subscribed
    stream_from 'pendant_channel'
  end
end
