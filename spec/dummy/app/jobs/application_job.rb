class ApplicationJob < ActiveJob::Base
  active_job_channel

  def perform
    fake
  end

  private

  def fake; end
end
