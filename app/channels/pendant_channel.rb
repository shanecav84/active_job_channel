class PendantChannel < ::ApplicationCable::Channel
  def subscribed
    stream_for 'pendant_channel'
  end
end
