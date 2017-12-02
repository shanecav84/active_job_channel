class ActiveJobChannel < ::ApplicationCable::Channel
  def subscribed
    stream_for 'active_job_channel'
  end
end
