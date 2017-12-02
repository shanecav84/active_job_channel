class ApplicationJob < ActiveJob::Base
  active_job_notifier

  def perform
    fake
  end

  private

  def fake; end
end
