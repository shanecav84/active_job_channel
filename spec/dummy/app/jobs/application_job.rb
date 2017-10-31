class ApplicationJob < ActiveJob::Base
  work_as_pendant job_name: 'Job Name'

  def perform
    fake
  end

  private

  def fake; end
end
