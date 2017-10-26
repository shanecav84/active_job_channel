require 'test_helper'

class ApplicationJobTest < ActiveJob::TestCase
  test 'work_as_pending' do
    ApplicationJob.perform_now
  end
end
