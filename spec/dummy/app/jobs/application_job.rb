class ApplicationJob < ActiveJob::Base
  active_job_channel global_broadcast: true

  def perform(identifier)
    @ajc_identifier = identifier
    fake
  end

  private

  def fake; end
end
