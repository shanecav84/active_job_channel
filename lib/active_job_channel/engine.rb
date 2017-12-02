module ActiveJobChannel
  # An Engine ties us into a Rails app
  # doc: http://guides.rubyonrails.org/engines.html
  class Engine < ::Rails::Engine
    ActiveSupport.on_load(:active_job) do
      require 'active_job_channel/broadcaster'
      ActiveJob::Base.send :extend, ActiveJobChannel::Broadcaster::ClassMethods
    end

    ActiveSupport.on_load(:action_cable) do
      require 'active_job_channel/channel'
    end

    routes.draw do
      mount ActionCable.server => '/cable/active_job_channel'
    end
  end
end
