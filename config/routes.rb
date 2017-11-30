Rails.application.routes.draw do
  mount ActionCable.server => '/cable/active_job_notifier'
end
