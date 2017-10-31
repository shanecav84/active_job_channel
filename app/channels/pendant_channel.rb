class PendantChannel < ::ApplicationCable::Channel
  def subscribed
    stream_from 'pendant_channel'
  end
end
