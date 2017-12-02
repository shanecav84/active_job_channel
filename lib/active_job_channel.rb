require 'active_job_channel/engine'
require 'active_job_channel/broadcaster'
require 'action_cable/engine'
require 'active_job/railtie'

# Top-level namespace
module ActiveJobChannel
end

ActiveJob::Base.send :extend, ActiveJobChannel::Broadcaster::ClassMethods
