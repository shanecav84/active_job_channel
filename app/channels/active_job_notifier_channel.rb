class ActiveJobNotifierChannel < ::ApplicationCable::Channel
  def subscribed
    stream_for 'active_job_notifier_channel'
  end
end
