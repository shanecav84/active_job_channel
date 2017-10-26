class ApplicationJob < ActiveJob::Base
  work_as_pendant

  def perform
    p 'Perform Application Job'
  end
end
