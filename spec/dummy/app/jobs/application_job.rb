class ApplicationJob < ActiveJob::Base
  active_job_channel public_broadcast: false

  def perform(identifier = nil)
    @ajc_identifier = identifier
    fake
  end

  private

  def fake; end
end
