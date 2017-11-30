class ApplicationJob < ActiveJob::Base
  active_job_notifier job_name: 'Job Name'

  def perform
    fake
  end

  private

  def fake; end
end
