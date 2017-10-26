class ApplicationJob < ActiveJob::Base
  work_as_pendant

  def perform
    fake
  end

  private

  def fake; end
end
