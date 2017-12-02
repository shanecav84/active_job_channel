require 'active_job_notifier/engine'
require 'active_job_notifier/notifier'
require 'action_cable/engine'
require 'active_job/railtie'

# Top-level namespace
module ActiveJobNotifier
end

ActiveJob::Base.send :extend, ActiveJobNotifier::Notifier::ClassMethods
